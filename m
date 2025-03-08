Return-Path: <linux-kernel+bounces-552845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDEA57F50
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A6016D9E8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE01EDA00;
	Sat,  8 Mar 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALcZLtON"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE87346F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472747; cv=none; b=khxUVsxVK9N0hIx9VuBYlzLiap1a8Os4KqFhLI8o+k9oIkkGdeLmGmnde04GXp0Nc26DaD8GQwEsm5pmJ79GNxBoWwf7r//TFq2gLuPt8t7t8FqnnxxQ3zab9a1Vf6IuvhudH5hM+QtvYgMxQe4nXa+sPMEU4nPL2Jrl/R8sqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472747; c=relaxed/simple;
	bh=6lYkrp7j38ZReiJhVDXiI8+AiHyZr6f3fz7T45LaJBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSn9OoLP572PdTYsDwOIGZDfVn91UPLHZ7NDm+WS3C2NVUpSq6gPLyJuGdVLEepXjrurqcWk2xJ9f2yKCOTvqripkhFxGEzebxozaHqx8LYFtDMt1bBkWgf6iGgozvPo8qZ1niphpJu807OmKROHPn46Qn1HqjRxNDj/Mj8rtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALcZLtON; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5439a6179a7so2947799e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741472742; x=1742077542; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lYkrp7j38ZReiJhVDXiI8+AiHyZr6f3fz7T45LaJBM=;
        b=ALcZLtONkBhg4vP+3upM0knRXlUTa38m2f/sgb6U1z6tisArNcdIHMqlNQsiOO8F6c
         kDS2TGvQQwq8Uwc2hJTiLb8Tuw5vOMBrK7DyQuWHksw+F1OZ/R4QD/DiRhRNG8pumU/x
         +99A01IecmQK0aF2kSxLzuFJPbb0Gvg9hvkurisMidnAeglL0tVGrB6Wbm3naHlSuFbc
         O58u+Z/IPdN5uTMLMzUGPEoGjKY1UPXLymagarFGaCIBZhY7DNzgBsl3/ImknxeQvDvI
         P8nGg8MBGJm471fhaiBRmJRhJFTiLgEI25sQDpBjJ1FVmrkI7ihRrepEHAHD4003MEk3
         XXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472742; x=1742077542;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lYkrp7j38ZReiJhVDXiI8+AiHyZr6f3fz7T45LaJBM=;
        b=FtburvU2NvmyIIWW+5ztkErFOCcDdoI+5vFGmAGGdNz694PzK31KZyzVMCQjlWu5Gl
         ickDAegCu9D4AIskBzBrNpd3SkTtgHFbtsALXWjpnkZOmJaye2Z7CIn+vRXJYovqjVtX
         dtY0fh5Ro+qDo1s3t5WwLNPNUoKot5NVhJpzPNd2A9gg+wHYCMCaXCYS1xq2i1snqym0
         wbdkVOCw1OV4BfPqJfrwBDZaDU6kvX0e23SYR87aTER1Cj+N8tyNH0irLUkmRzOOetBW
         l104deqPKlTN0YY3jCuOBjFpETacxtQYrCfr8uh79bcBaSNmd+hUF0v4y4etIm+BNdHg
         8okQ==
X-Gm-Message-State: AOJu0Yw0PB+VYDkjBvi5jRlpKzLu8WHB8O2Q3ArVEHGsyk8q6UMMTSHK
	yvmc+K7p+Q/2kPbc7IjSLGlRRCaGlaHkZDUSP6EB6Auv3mrld/GK
X-Gm-Gg: ASbGncsCG+Wa2Em39T+zGyRlae0qE+RFiwnYDgR7JPZ7x6q406Gxdtz3rpsmlKlji/+
	noShWqI7f09fK6PkBpuhvofgCjSFnYmyccj/N5rG3bJN44BYu4o/pL2s7IYWaNvin3uoJ8WAxAP
	raZRPratVvhALthiKDiAShsgwvUXtxzsy88vOzXZ78fgp1q2wp0twA8A/J9tbP2BlCic9tTUYIY
	6OX1m++OPyeybFIuQEsz9O4jqJgFNI+6/3/geq7oR43DJGyLbD/6v7idd3nd6laRKQvrr1xIjtc
	l3slI7U0nO2RpOLy+l6RPZVZIMZPM+muw1V3TMNPu5nwGqQ=
X-Google-Smtp-Source: AGHT+IGxFqYyjfRmFMjj5fgwD4oZQyW7jve86sy5HVGThP3SI9s+JURLO7/Y3pwqdsKAF3ZqPylE3A==
X-Received: by 2002:a05:6512:b14:b0:545:2474:2c9b with SMTP id 2adb3069b0e04-54997ef0dd2mr1431658e87.22.1741472741986;
        Sat, 08 Mar 2025 14:25:41 -0800 (PST)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc085sm921967e87.161.2025.03.08.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:25:41 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 059325A00A4; Sun, 09 Mar 2025 01:25:41 +0300 (MSK)
Date: Sun, 9 Mar 2025 01:25:40 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V3 17/18] posix-timers: Provide a mechanism to allocate a
 given timer ID
Message-ID: <Z8zD5IFlXhu9WXdB@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308155624.526740902@linutronix.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Sat, Mar 08, 2025 at 05:48:47PM +0100, Thomas Gleixner wrote:
> Checkpoint/Restore in Userspace (CRIU) requires to reconstruct posix timers
> with the same timer ID on restore. It uses sys_timer_create() and relies on
> the monotonic increasing timer ID provided by this syscall. It creates and
> deletes timers until the desired ID is reached. This is can loop for a long
> time, when the checkpointed process had a very sparse timer ID range.
...
(I've reran test with new series)

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Tested-by: Cyrill Gorcunov <gorcunov@gmail.com>

