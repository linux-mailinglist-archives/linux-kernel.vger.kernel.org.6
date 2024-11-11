Return-Path: <linux-kernel+bounces-404755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05C9C47B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62C31F24E65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A741B6555;
	Mon, 11 Nov 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCFW8zOT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE213698E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358661; cv=none; b=CZzB52V4Wi/zItW6VBV3HMAw52nwWkcGcnBTrRH7w4T73IlY+Jw1711+3kty3oderdg9L72zJFs7akXSN+035BHb2CJoFDTMPdaEtJ+M9ga1+ur3W39PBPZfBWVRKeuR8ZKWaAA2w9ZS6eg51Aw6sUGbyQBDwJRLgK49S/WnBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358661; c=relaxed/simple;
	bh=Vc5nYJphpxePVqXdWVJpcK+tQTcghIrwNPx+RTzFR6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E94o3V9wWz11WVDV6aXjVGVyPydgPZfaBCPB7lfvV+UXCEJK1eIoIC4RYLBUSnLKuPTk2Dd6BaeHb+8ABUVaXG4yXpW+GYX62NNijKfsNCfDpybxbuwBxmthjbDWQXoL5J6goLPk8YoHeYbtDTlkF3JJ9Lz9fI5QXet1DA6aMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NCFW8zOT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720be27db74so3675258b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731358659; x=1731963459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqqAJkrv0yVPoqg2lzfc8sKJkc9kA0WxcjS+iK6jMjo=;
        b=NCFW8zOTsu9M5syQl55Bltgmpd2Wl7GhXLYhtWHTTSbrMlaL+7/HR8W5OELm45/bzw
         8sW3pTldSLn9iqZKspS+5kHxc0FltaDlpo2UekHcWHqeYcdn/h1jgx7+tNd5bDxKiN1j
         XwolAdQHF/V5FcEfk6E6dSX5dadKbtkblyDZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358659; x=1731963459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqqAJkrv0yVPoqg2lzfc8sKJkc9kA0WxcjS+iK6jMjo=;
        b=aBx4I5KQsViVaj4zEpnAQ32VHRs62euV/cMn09+XNbKcvD+oTGMvR6rnSFB4zFB7V/
         EDrRaZzV5YRJE8693Vohz/XnurGsR+Z6qd66uJFnyTr/e1HOAtje62goBeWoV1/EX1Pb
         zIqnTgrIqpeQjFrWcINt6nO3sDQ+5nUB6pAiFjxB+2WIxnJRGDsYS2ny716jJEk8e56D
         pXEpeaqfHORcs+aJhKK83UGjPJHpZYqvsca+pRCtH+8yRym9r51CUfnlIEfyevT1KNws
         eKJ1gykmsThyCas595qjaiL85W3F+UH7oM3+FnELrhjyjFsDXCSAdTm2B3UbJ3WWme6y
         CKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHu1Z/0mQHvvwTq3J55rQSXWg0EWm0+Vmo6qemV9ojn+YsjFTysY+EseiiZ25+/GOW0vOwv9DArWDdcBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrz5S2pcdgrvnbfNtk4Jzqyohzhl5g/tFdPVFuzTCVAdCTXfk+
	PW3TtH4DK9d2kiQ4mo8bu3gx/MjGRYy3h0k0NVSWPKJyI7nKwhqSi7Mpt2/Xhf8eikbrWceiO2Q
	=
X-Google-Smtp-Source: AGHT+IHzObwGU14s/KxeM+v9itqBClQluPUEnyodWHLybERgim04HWyosSpD1xIVg7mMpGkGYGGCZg==
X-Received: by 2002:a05:6a00:13a3:b0:720:3092:e75f with SMTP id d2e1a72fcca58-724122d2c59mr25497376b3a.8.1731358659057;
        Mon, 11 Nov 2024 12:57:39 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799baf7sm9972686b3a.121.2024.11.11.12.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 12:57:38 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca4877690so3295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:57:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW8wv8OixxSOKlCVtCy5xwAQ3sQnkbxKi3gZHzc8PNzAV6RuYI5y/DPeRQrr48lgHAsth8OxMWncLQ0vw=@vger.kernel.org
X-Received: by 2002:a17:902:da91:b0:20c:a5fb:7a0a with SMTP id
 d9443c01a7336-211ab402b1fmr475765ad.19.1731358657430; Mon, 11 Nov 2024
 12:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
 <CA+ASDXPKosUXy1x7Yvbu3pEYiMfDPSt69xt3Jq-zHw66yeUSRw@mail.gmail.com> <6f0cd0ce-f217-4397-8785-7590d1e0e0e0@linux.ibm.com>
In-Reply-To: <6f0cd0ce-f217-4397-8785-7590d1e0e0e0@linux.ibm.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 11 Nov 2024 12:57:25 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPw+1mvHaS21_Z=E7cCsErv8sMseW2pBCMRdB4iyVzzKA@mail.gmail.com>
Message-ID: <CA+ASDXPw+1mvHaS21_Z=E7cCsErv8sMseW2pBCMRdB4iyVzzKA@mail.gmail.com>
Subject: Re: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: kees@kernel.org, nathan@kernel.org, yury.norov@gmail.com, 
	linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nilay,

I'm responding here to try to help move things along for you, even
though I'm not a maintainer here and don't have a strong (nor
authoritative) opinion.

On Thu, Nov 7, 2024 at 5:38=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> w=
rote:
> On 11/6/24 23:30, Brian Norris wrote:
> > IIUC, he was hoping for better compiler diagnostics to help out there.
> Hmm ok

AFAICT, things aren't moving so fast there, so it might wise to try to
silence the problem for now.

> > (Also, I imitated Thomas's .config notes from that report and couldn't
> > reproduce with my GCC 13.2.0.)
> >
> > I also happen to see there are a few scattered instances of either
> > disabling or working around -Wstringop-overread false positives in the
> > tree today.
> >
> So shall we wait until we get better diagnostics from GCC or can we bypas=
s this
> error temporarily with either using __NO_FORTIFY (as I proposed  in my an=
other
> email) or disable -Wstringop-overread for kernel/padata.c file? Later whe=
n we
> find a better fix, we may then revert this change.

If this warning is causing pain, then we should probably bypass it. I
*think* there's less blast radius by simply disabling
-Wstringop-overread for this file, but I'm not completely sure.

Brian

