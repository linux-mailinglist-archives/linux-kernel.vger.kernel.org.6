Return-Path: <linux-kernel+bounces-267644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A87A9413E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8F280E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585431A08B6;
	Tue, 30 Jul 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2mKtnhg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE451A01A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348353; cv=none; b=NG9VsvBILj2ONvEOCkdOUOPtefPG2rGaZSu1PP+g2ro+c1UTRPp2zkD5k4EJww5x85JSEm76puAnOKQLfhp4uMWxHuyumpuxC/Gx+b9TY+oobdldA6FcVcqyU2w+wYFkQsyfO8q7IFvAGjpzCTk89WBq61iVcHN5v0g2VqZDML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348353; c=relaxed/simple;
	bh=VC3Hv+Ia3AY2+pr6dBLfrjDouP+kBGT4vnIdcpyk174=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcdIcXbooLlGg80UpfkmEBcmEmtoXjdetbStLnpRLpg5z8SY1SwAyX0nPtyQtMxupQCiB3X2flxHMwL7EC7wXxsN4orxNvwAKJROKD5d/VrRTbbnJHLHB43NJfZWWWJ5Sb47Vo3lJcj+hk22U0nYklR/Vq5xL4uCrPqNiv2skbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2mKtnhg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so7376802e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722348350; x=1722953150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC3Hv+Ia3AY2+pr6dBLfrjDouP+kBGT4vnIdcpyk174=;
        b=L2mKtnhgZX5r58eIG6p9HWtbDYd5yiy4p71HwjTHAzdwoEVEZUOYsC6Lr4T8TOUOUG
         GITQEN3p6V+aSRIqmoMdtBzHEVnS5gvVpGexTxS9yEb2YClLP9I3ijNXVBxJ2bzU+/9W
         C8Bz7tMFOyS0dpbqg/1AEmFgfulEQjlWq29zMnlI1olLszWWR669q0PgRxeI8ezfWA0i
         UweRxN5P1z61Uo7trR8EiK786UeHCyVKd9bvWQq4LRoRJGtu8nD8XFuDxcBTZ0JOx6UF
         a3B19i37qjRf0lEBDEpMe3WN7faHYCFcqO/RlC+9eU0B5jcluBOSwXS1SIgoqP0TCmpS
         YTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722348350; x=1722953150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC3Hv+Ia3AY2+pr6dBLfrjDouP+kBGT4vnIdcpyk174=;
        b=laoHHh9rBefyuzyEN8K+JRrQjOrkB8CcppJhDhFNjYJXgdsh1b0n9iU4HIlDziG/i1
         PqRBHTW5v0xmtyBymbM/7R/NTv7k20GE5qZ9gDVvrgZX6fw9N7Jt9d3SiyEDTkA5Pixc
         TLfkp/1zbsXIHud2A6yEncKDumDcU0aocMpLTKB9kK5XFkRHPOcDHLj9Vj5tcnkizEQ8
         TBA5GcZruYPN7e4VsfKl1dej89DfWtJl8QKTDe0c2Q2ARdbdw7/5lVSwpUGh9EtpbKmK
         so6Wfg27IvswDJD7aPxZRZaHWWkYrPpKLPVRnoGuQCD27S0Yy2lCFoEbEGM77WxFKaZL
         QN7w==
X-Forwarded-Encrypted: i=1; AJvYcCV4gwjqPCdGNB2qrTMI2QKqRLVSsoGu7xijqiWoqoSK6AlE2GlO/cSd9mqq3fO+ku5DziGd0veOoHvNsRB/oEP9dLNbttNT5lrRs5Kz
X-Gm-Message-State: AOJu0Yywz2HYaLNoE5uvwxRvcO8ixmb2VVXZprR1tFrbiOgooyKYistO
	RmLeEgQulZEZpgPf+Tpzrf5T+Viy6m0wpAxz5/YLKIMp+qnUnbtp/UZTJXm6YjNWG2MOMukannr
	PXRRbzcT7ad5GMNfqSRbkJdti+kI=
X-Google-Smtp-Source: AGHT+IF98QuDW7lc53dcOToWH9YfWSH3jB7gchsnJzoJ+D7ZfI0i8260ABtL4jLpb2mCN4SXEymoL4k87b3Ph+1DrSs=
X-Received: by 2002:a05:6512:b96:b0:52e:767a:ada7 with SMTP id
 2adb3069b0e04-5309b2c3ad6mr8984085e87.50.1722348349571; Tue, 30 Jul 2024
 07:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729084512.3349928-1-leitao@debian.org>
In-Reply-To: <20240729084512.3349928-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 30 Jul 2024 23:05:37 +0900
Message-ID: <CAC5umyg90wADke-YRC2vqrcf6Dh=47HmQ4GApQd8dNeJ6BHG7g@mail.gmail.com>
Subject: Re: [PATCH v2] fault-injection: Enhance failcmd to exit on non-hex
 address input
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, leit@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=9C=88) 17:45 Breno Leitao <leitao@de=
bian.org>:
>
> The failcmd.sh script in the fault-injection toolkit does not currently
> validate whether the provided address is in hexadecimal format. This can
> lead to silent failures if the address is sourced from places like
> `/proc/kallsyms`, which omits the '0x' prefix, potentially causing users
> to operate under incorrect assumptions.
>
> Introduce a new function, `exit_if_not_hex`, which checks the format of
> the provided address and exits with an error message if the address is
> not a valid hexadecimal number.
>
> This enhancement prevents users from running the command with
> improperly formatted addresses, thus improving the robustness and
> usability of the failcmd tool.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

