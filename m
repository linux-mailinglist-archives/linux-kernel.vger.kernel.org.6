Return-Path: <linux-kernel+bounces-357590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2199730F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC812856CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306A1D4176;
	Wed,  9 Oct 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZU06nU+N"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D6137C37
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495121; cv=none; b=rJiLfXrmSCFZH43YH+Dmf4itoWdutpGfy8YpKydSJVjGFeYiBVwBaFGP/sdEFxZIf4hJt/58Tyj+PTK0nde3wavqzdatLhecQR0cWgz+phOoupqNjATmxstIxwSw7BGZUa/bte5scwrShfmekWtBkhjXVPghVxKGhSZi/I1/Seg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495121; c=relaxed/simple;
	bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpH59ogHpRUJ178gONquCP+0BAfXnW9YONY5PYLnkrxAhyYaF8RKqUs0hPFUH6AtdJw9xR4xDZvkfThCvWvp1QnItNaai7rb6LWd+dbKN4i63XXa706QyIANQXwjp9SJ/c7ucOssGnJ/5yp7wWr+S6URLbSFbc9G5FNUnxYuLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZU06nU+N; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso182545e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728495118; x=1729099918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
        b=ZU06nU+Nf3773zoc3fe7n1VdYvjz9bSlOxU7UVd8gQTCmRxQ7+yJBh7DxT4uhSpZNa
         VNp9Qtn1TbZML56ede7pOZFfSehxswu1Ar/BwTo6NYE308Ri8cIC+QK2oTqCnbyrBemv
         TVGc84r0/a7dh5HBIsxnP25cbKSRsFZ1BQZAC6a/pnDppmR5gtGv9O6i7WkGNS3krmAz
         gyRDJCbPMLEzZ+e576noDsiQrTTvZ4pICiJByQJJOF6NkSmCGztbHxdFwSbX2X6ewcFn
         io1v7yZwAWvMAgYn3v3rZZxX5r83xnhL9m9cjOkp9JK7DSFOpqUP7tCsmPLIOc5VfrYZ
         PMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495118; x=1729099918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnHcOEt2Q+E/BSuDqJ36ap3bLP7FuAm5tWk0fu4xuqk=;
        b=ubq4pv8Q9HXPrf8Vwoe5EZ7bvMfi8+JeHiRq4vR3SrwCC7IH3TlCTFh0k5Urbqomj8
         QWfDVItYbSPxRQFkNXpk6OX0BfUppbBsIME6L7+4L06pznC9WpLAkRHED85gD+Bz+rzg
         UE/par7z13gUtvMv3Yfvx13Plusr+3EDAyI3dnr9mHVYoLNEVt5nM11w5TlLaq0VubMi
         w1YmXtpSc/DG7iK17amoQfBPFIYERvMNwjbn9tWUOuWQn/0j2wlvnLq+IMRlDlTfw43C
         gbUSCXlMziPHZmWMr6HCebpvnPujG4+uYlADk0HTMOivK/ZL682Mdj/uoumoC8Xb1uo6
         /9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWIgtf5nWWTLm3bkisg6qmDF3WWzf5++HG3uLf5RR6dTSIRhfl6HKj350LPfOF+tUIZkNQr6whLS7IU118=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNh9XMu/z+Zv28DMSqoIkNQVPyPXsLUWfD96gbPb4Fgbr8P5E6
	arFijSGA7bcSKToYH8Ladg4qR6+Y9+VN7FOHATkFEhzvqOKjsNOyjWOmuxU/bSiW+DXcS6w0Fok
	8ki1UFgplIamcshL3MDxWDo0IdF8fG8AvNvY=
X-Google-Smtp-Source: AGHT+IF6GCJdoJW6FolMqGZLbIHS6bpmoo62eYMZ6TI055KcdVX4GGTofCCv1p67aeAG77Mk+PVpRnvqrHsSe4d83B8=
X-Received: by 2002:a05:6000:4182:b0:37d:4586:948f with SMTP id
 ffacd0b85a97d-37d458695fbmr2622251f8f.42.1728495117653; Wed, 09 Oct 2024
 10:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 9 Oct 2024 10:31:46 -0700
Message-ID: <CANDhNCq38L8o5vKJaC8WzfvqEoX-xrxX=-n6ReohKK_vR65Sqg@mail.gmail.com>
Subject: Re: [PATCH v2 03/25] timekeeping: Avoid duplicate leap state update
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
> previous invocation of timekeeping_update() already did that update.
>
> Put it into the else path which is invoked when timekeeping_update() is n=
ot
> called.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Could probably use a comment in the code to that effect, but otherwise:

Acked-by: John Stultz <jstultz@google.com>

