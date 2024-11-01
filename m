Return-Path: <linux-kernel+bounces-392261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA69B91A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6169AB2162C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC1F1A08A3;
	Fri,  1 Nov 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKNZGnsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CE1A01C3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466870; cv=none; b=BNg6L7StkD44qBr1UzhpYtcDOyj/NNVNjeG0v/3K3Afx+LzOcxQxKCMOZ4CokqMOdj9p96w4lzbSgL5OMBKE2ckIe+wgRN4EOlC5UaxulXB+0rtX6MVcjEzqujipMqAgx8ABvfeDfKTOxcS/yDvrqaHZiMQODnnIvJx/mvG9O/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466870; c=relaxed/simple;
	bh=DmVXF65mWFeX6NDHfVfZ/FYPVaHP/7SYg5NtzD+3eKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UugTO86GdRpZ1iUW00Or9gvzeavSc+N1RVDNan1ZGb6IJU5xDWR+PHyQw6kqoYSSRws99jDxe/imJ626qFCZtzT5YMqJSSTyz4IJWKWtZKbFu3wMnJhF/HpmrzSm1/+421aT09+aiV/XLV5MZKMHmD6DHQvwp1N58CrHCMMb2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKNZGnsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D2EC4CECE;
	Fri,  1 Nov 2024 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466870;
	bh=DmVXF65mWFeX6NDHfVfZ/FYPVaHP/7SYg5NtzD+3eKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKNZGnsW56zgyR/JLiEpNzDLI6PcCz1hk7K+f+csU2wOMFWLttU+tLEiWSWc7dwt9
	 w5AcOhvFg8H1LK8kS7g4d6bvvovswlWis7H5UKSmpNblool3wuQroyG3jMfMNgXJLm
	 B9dlAXXaItqMHJlHVq5ELgFOEmK78uiBmVXLK6ncXdK4YlQTO6AzVBtJxD9vj7zOAj
	 wi1qujvqbo+LDXDRIiCrRnRh4r4whiNQRrGrySs0QScEdQTUSg+9BW8LCSTU7QlD5W
	 AeOvnAiBU4G50CH6SQAkGQLqamb6394ehMMIi8k6lecRHWc7d84+F+YJGrHr0c0aiV
	 W8lje7UM27K7w==
Date: Fri, 1 Nov 2024 14:14:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 03/20] posix-cpu-timers: Cleanup the firing logic
Message-ID: <ZyTUMuGUQGraJgaR@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154424.740750741@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154424.740750741@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:26PM +0100, Thomas Gleixner a écrit :
> The firing flag of a posix CPU timer is tristate:
> 
>   0: when the timer is not about to deliver a signal
> 
>   1: when the timer has expired, but the signal has not been delivered yet
> 
>  -1: when the timer was queued for signal delivery and a rearm operation
>      raced against it and supressed the signal delivery.
> 
> This is a pointless exercise as this can be simply expressed with a
> boolean. Only if set, the signal is delivered. This makes delete and rearm
> consistent with the rest of the posix timers.
> 
> Convert firing to bool and fixup the usage sites accordingly and add
> comments why the timer cannot be dequeued right away.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

