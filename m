Return-Path: <linux-kernel+bounces-203141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7678FD6EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421901C21994
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC61553B0;
	Wed,  5 Jun 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxnpneoP"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C242149DE8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617633; cv=none; b=aGvqIJrjNLAXpbsUvBjGFlJV1tqr9QI0iLfYmAJS2AQ4VaFPZ5afbaw8ICewJ6Ei7Pw+l5COdvUGsSfTeEr+x5BQMFWPkXJx5S69VNePjiFCzkQTD4IpK4Qk18uuJKv/7MkAqMAoUArwtgPQ0NBVGNdynQQof55+igg9ZbbDC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617633; c=relaxed/simple;
	bh=XSAnJpyRdvYHk4w7B0EQjoJKput1jJxXM/NOCbq9aJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKF117TPioA/4W/SgVv7ksEbbBJv+G/Hz/6GnjOMrJEuKopGNgpMVRglcqpgQaixaZyoEfYEzWm0VzjBGBUjA6SISA/JaeAwgbNB+l0DWEf8iiZy/BbOcsNE1ASU9pGqqA31xgXNm2kNc18xxaZ7dcwiyJBP6A5VqM4aZfFLpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxnpneoP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df771b6cf71so276261276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717617630; x=1718222430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWrRBVw8WH9aDzTIbHcqeTOsdNqkKD2w2Spjllp+r5I=;
        b=jxnpneoP0Y2JAuwYtfKh43naOVdnQg8Tbm1DZ0jDaFrKGJiFFdanCMjBPis+Gk1CzP
         Id+NISeuBnlP2XWGrrgHpFmfIowjcSNNu19MDbpX4MawlL2dAFBrc8GwWUMLfZ1Y39jC
         kJ3z5MwcEMAlOEIeSXfWdmdTxLgmu5A+doyYTAbZ/45PGj2Pwz5SdSTTP8ZA9NKJQJiK
         680B7Z/bbLe6MHIZkuQ4PRM13AAxp94tBhFYXqd2PI4cefVyqv2C3QORXP5IPTOv+9Wh
         1dP4Lw8C4gFcCgziwlS5X3LkS3FnB+e5NFwCHIzBzQRF+vn9Pb2vbcw7xqzT++152T4A
         v02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617630; x=1718222430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWrRBVw8WH9aDzTIbHcqeTOsdNqkKD2w2Spjllp+r5I=;
        b=hwqiZrCUbfFjzwnCK5BZp5HILH5+cpVw+M9YpcKw14oCMitu5sZ3rxcLxVuK7eOFRC
         1mFZADvBqBlJR48p6NFQcxSy1U3PvmniIV78shWNUkCdySCQCr14jOE60aX8gSPH5/xz
         frjYYPVs2kdUm20ZBaSUI2lt5MA4F+7FKUZ9klIRraJDzACOE3aTILny5K4MEBinY9/p
         nm3oCrYyVOEy4dB1H5nK4fXosG9f8yYLcIN5CR8iR1682C+8wHT2u/YjN8W71gt59zXo
         GMZiZa/4lTnFqZ5R3Mbufvh/7MWK2vJITRlraVsvDuSPGhl6LBAMxUh1inspBlQXQOp1
         uxgw==
X-Forwarded-Encrypted: i=1; AJvYcCVwm2+if9cys7WeUbSzrywu5HytMrB6bTKhj3bjLQOL5/XL1rk5G9dv7EKVBdMZIP1xuRz1Sdq5ha7ENK41sF/4CjwJcCLefZvTazG9
X-Gm-Message-State: AOJu0Yzscjb4zDBxr2zWCFYUumUW+hzoAFDRSXyC8DD55R6A4cB1Bbjh
	L9oBTRkhMjv+/3aVSZxTUGC5S0QEYXvlzJ9nAqSkYVtXQpf3QhEamovB+MsuVUn1Raea04nLLr+
	2ih0oewv4aIw5q6VD5BReGyeTLQbvhgHMQwAn
X-Google-Smtp-Source: AGHT+IEabyCTn3/HlPd1zdAO5mGc/Ul7zOKCqngo9duOv3aG2YKtL9PgTUxbuLj6hrUH+O+3fukrfRtdp3Lo7D6XN+M=
X-Received: by 2002:a25:cecd:0:b0:df4:ecf4:b9fe with SMTP id
 3f1490d57ef6-dfacac7a81cmr3252157276.61.1717617629849; Wed, 05 Jun 2024
 13:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605123710.7396-1-00107082@163.com>
In-Reply-To: <20240605123710.7396-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Jun 2024 13:00:17 -0700
Message-ID: <CAJuCfpFY=e3zNOMHgTM-HGxhk2c_nr=ODOo3Fk67_D4gNgzx-Q@mail.gmail.com>
Subject: Re: [BUG?] memory allocation profiling: the counters are not non-decreasing.
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, keescook@chromium.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:37=E2=80=AFAM David Wang <00107082@163.com> wrote:
>
> Hi,
> I was playing with this new feature of memory allocation profiling, when =
I plot the data, grouped by caller's source dir,
> I noticed that the counters are not non-decreasing.
> If I understand this feature correctly, all counters should be non-decrea=
sing, right?
> Or is there some TTL for stale items?

Hi David,
Counters can decrease once an allocation is freed.
Thanks,
Suren.

>
> Following is a simpler script demonstrating my sayings
>
>         $ for i in {1..100}; do sudo cat /proc/allocinfo | grep " mm\/" |=
 awk '{s+=3D$2}END{print s}'; sleep 10; done
>         1194453
>         1196935
>         1198957
>         1199716
>         1200770
>         1190795  <--- decrease here
>         1192702
>         1193070
>         1193812
>         1195069
>         1196491
>         ...
>
> FYI
> David
>

