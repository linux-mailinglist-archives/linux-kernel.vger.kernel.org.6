Return-Path: <linux-kernel+bounces-320828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EB97111F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66351F23BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328A1B29BF;
	Mon,  9 Sep 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9u//P68"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7C1B1420
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868866; cv=none; b=m/UbOe4qvouuFniyPZCaXKJnWmY+ZCcRmJgmBnJghOjrIFerT5+nbx3uShldPY6SEEzHOo+BoRHkX9VzRrygLSO6hBFUHSvyRxKg4p5HReqkIcir3acSjlaCgYQRdu8neZUsaHXgNVtVI5udmZdh7xGNtjulEQ7hWV0pgUgZ574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868866; c=relaxed/simple;
	bh=M1SnVrjyFwIbonn93AI37PHh6KC86FBSMlypv6VaacE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sslbkdkxT2Cb4rdIXjXXYdGRdvbGhWDZHCDOkGDYqAhHaoBhK2FzuePYiPsOStigTlUc1VGqIaO59SQ1a5fbDENbVpjsIF7Gb/5JrM31WNSrJbI9P41jPwb1pmtWrZ3PxiO7rfWlm+GTNbX/7xdF++C8hPdxTHEQyRGXKYKMbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9u//P68; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717849c0dcaso3595282b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868865; x=1726473665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1SnVrjyFwIbonn93AI37PHh6KC86FBSMlypv6VaacE=;
        b=c9u//P68XsuuaSwGFcv0XwXARHE9mqt1vcU11u5Mo4xkupJFhBGsvyzcDjSSI8hxv3
         1pFFYtELP03fyxICDGzxRsHp3sStYpBE2rcTY8ACb+KHy+uejNoMTi8EEfk5sZO3hmTR
         6Wk4uLU5b14JcdEA+tE56geZotr95XJ2m9WXEP2kzORz3MuJIcUannzRr2swfeRtOKqT
         r/7zzYOmWc2JON97U8OduwzRImu9xEXli1prXyx3/432msSPrld6+QTOpn/NMnStUveM
         W7kD/mxw/7A+/GOqLHL+Tv28MQjN5WKCCEs2cg1WwL1EQsPFm/XenSCHFuG0P1p7YOGj
         7iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868865; x=1726473665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1SnVrjyFwIbonn93AI37PHh6KC86FBSMlypv6VaacE=;
        b=HWkjVL5xz6mvLkXIzG5Gte65VmkrOltyUggfI6YnETJCL9/dWcWKo5aT3Z42SVnRpp
         WSnjL1KST9MbnveBByC9QSbUIqbVHoG2SGmEQu+BqmVO6obLh9nsKv+8e1g7Rae/vcta
         +YtG6wL1Zi4x7Auke9piGSaQzdQXrN6XKzT4K5Bok3m/dh6X92O7lBR1CCpZ/+S4ycVQ
         Uhw7ISg/5dNR0Hmwzdgq3EVuNA9iiOPAhpeC0PfbSGptjzd26/wWA060J+TAmoGduYNr
         Kyni0b1Vr0gNGmRrAF8gP+eYhCtifV0nYo9q4/9XaXyYXbmFi2f1mnMCQcwSuBJXjcPV
         N4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPLbRqMcvDlurqu2jXYLa10FXw0kOxQwhVGFc7mnrtfiZHyWF/zjTHntmVlDqStUfzo7vBlaLtT+FFRyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdJ+8q0GpxRam+KAAnTI68j2Z1mzB6F3sQJdJGp9JPtyEEktH
	UTR72qqREJVbgtN/2Al0W1rLBnUdSwqsKN6eH9Ts2Gl8murw3T+D96Cukqr3g7EZe7RaE78Imf4
	MgPxwn+pZBL4pPq21QvUp9o3cgPIXDr8bdxY=
X-Google-Smtp-Source: AGHT+IHdwPsJrzBChtnBGdvf4x/dY1fxzfq6b+Uyf7a7woKfUlA2U3MS/SjECYiyhnNs3EOyU6Ur2rCGhE4jqVAIzUE=
X-Received: by 2002:a05:6a20:cf8f:b0:1cf:39ee:f259 with SMTP id
 adf61e73a8af0-1cf39eef59emr4016543637.5.1725868864521; Mon, 09 Sep 2024
 01:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908180902.3196764-1-sayyad.abid16@gmail.com> <ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com>
In-Reply-To: <ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com>
From: Sayyad Abid <sayyad.abid16@gmail.com>
Date: Mon, 9 Sep 2024 13:30:29 +0530
Message-ID: <CACVUEBme-MqZsUGYE=5_0yYxsyeqQA66o_ihW4NDw02DnMhyFw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Fix tabs for indent and + in comment blocks
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:04=E2=80=AFAM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/8/24 20:09, Sayyad Abid wrote:
> > This patch fixes the use of space instead of tabs,
> > removes trailing space and adds "+" each line in a comment block.
> >
> > Signed-off-by: Sayyad Abid<sayyad.abid16@gmail.com>
> > ---
>
> Hi Sayyad,
>
> please apply previous send emails to this patch as well.
Roger that, will correct this and send a v2.
>
> Thanks for your support.
>
> Bye Philipp
Thank you!


--=20
Abid

