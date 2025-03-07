Return-Path: <linux-kernel+bounces-551255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56682A56A23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6619F3B5A61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850B21B199;
	Fri,  7 Mar 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjYqWecu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAED4642D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356976; cv=none; b=grdPduqC/4mTMiAah6BrlvLKvRxa4keS3JxwqhYsDjJw80RwQjHiKhw7c5pgnrPlsWeh1z9YpYjwn9lwGQdJx7KPoHIq/sfcjEKFNOaTg+PB53aUujBaTm772J06GtPlzdBbIbRmGFfo6IvXkdQmQsYI35KTs115F1giM6vs9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356976; c=relaxed/simple;
	bh=0VDFS099iKYpZbDhRyy8QlOrFOKSjXD5NvynzrZW82g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4kWlVbE4IGVJVVZsyEXR5aHquRU2SaujQlHLaxF5TAibAchxEsBJySKVTdQzGOM8K63JAN/xE5OZJ6PYayqtB+lffGRbIZx1zwkRwi4IgLbG5DTaLNbl6SVF89dbntwHQi4pEm3XZ5L22MdNcw7pske62oXTG6RDeoeXe747eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjYqWecu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6024C4CED1;
	Fri,  7 Mar 2025 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356974;
	bh=0VDFS099iKYpZbDhRyy8QlOrFOKSjXD5NvynzrZW82g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjYqWecuDT8DbXkmJpGwXXK5MoloYGCkE6XnHPurfnBQvouw5wce6V35hCUomkdeB
	 gSXpLfB9fppdnFlzDo0wm9Bcq8RqSNGh8vBMCrswGi6YCTPJc4XJ/5fXKcRcMMLX/P
	 X9IOq7F+UFjqhPpQtbAEEcqsuEjEvj3YExXFdKlfBr4spEcbRfyfYg5lh0eLh3++zB
	 YWWzz93ZwghYQkbiA20pxOcPmjMLx88zhbx9oe7qZddHVtnwBFCgjFR8lbH9ehPkJk
	 21Mqahf6ekcj8I5QBzrNDYmBDWG1Ieve1ZEiTnUtnq6isEz8eKoq8GJ5OO2h+SZwzd
	 eiixYpNjVdJng==
Date: Fri, 7 Mar 2025 15:16:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 06/17] posix-timers: Use guards in a few places
Message-ID: <Z8r_q_1VYsqEzkMK@localhost.localdomain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193627.291265233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302193627.291265233@linutronix.de>

Le Sun, Mar 02, 2025 at 08:36:52PM +0100, Thomas Gleixner a écrit :
> Switch locking and RCU to guards where applicable.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

