Return-Path: <linux-kernel+bounces-556515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F878A5CB00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824803B89DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A79260A29;
	Tue, 11 Mar 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CcS3x7I1"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1E25F78A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711094; cv=none; b=Y3QuRso8CiQ+InQui21Qtj5/oHC0LtN8JlOOYTTSSBE0zrZXbR7vmz3CR19cF8UifplPXieMlGlVzniDA8x3CC3UHL8iHfmRLRiB/sYc80wdn/tp2nf0t3Tp+14rAMbuJHMKXmm2cWg0yHULW/d1SNuXddsK7mXpTShWtz6WRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711094; c=relaxed/simple;
	bh=k/qqYE18dumnTrExg52yxnDgHqbEw22SqqHqyAXOR34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxsJ7C56F8tIIafBRHJqMYrfRuDQp0OwasmRk31kEbwU+CrTys1MXK7d8vvCMojxy5b2eCGK5jBc1Cd48hOO7WLa36oWhiEDN1ssZI4R96NNFH/7fhS3CTUreiI4Y8cclLzmL4AQ2PETeDjgpwy7Dn0GzyLrw7NCXFnXaXoelXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CcS3x7I1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fcfso63531651fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741711090; x=1742315890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2J/hC01hBS+/+SHi16lHvEsy7aFLaWqMUUObIUNbiY=;
        b=CcS3x7I1Def8YQPhV2sP4D3Jaw73ir+Hqb2lRf8CvdOJs1E/ruu7l1w0x5BUpNd33x
         pnwTtsQQnnfAwAzfNiYVtiamjBPaE8N/N2OwTyRYsPDwJie3vdd6MOU6ZOjN5WnQUD8L
         NmGhhDt3lMKlpQYGGYJraQoCgcTYy3tvWD/lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711090; x=1742315890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2J/hC01hBS+/+SHi16lHvEsy7aFLaWqMUUObIUNbiY=;
        b=KgqfvXu2kwrThguGlYafahITHxA61swQIAPH1MHrT+DbwL7diyf20fENeYtabDrSS4
         ox8SMRp43/COS/Rd4WL11Kdz7XA6p4MePQK6H8IcmUrc8kCsw99IioBbeNMKR5Tbyk9k
         KIcY/BdpUNTN0n3xjNkBc+UrfQkAhcZ3mGPfO4QEqHuyD/PmZI5sdeWLlbSPVwymXEwC
         SLVnlSkS+D6apkmH8ymaDoMRg01vgbE0zqWC9K2jTGf1/7ai+tsJI16E0SUlLPBIRibh
         NkhJlmhg2pv/KdbNNDPEttN9FUNnCqD6ZJgzq3Su8t//bKRAtCUt4LY2b90NJRHhBs78
         XBBA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXtrEpQWQeUVKneomU9teZIu7fapkiR5K8bk87pbXWOlmqcvHQJMA7SCBD2uMJWedR7+a5trVn50fbeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl25vKS92Sgu8DpYTFN2kh3G/QPXZW5nlA0XtS3lZSsT4fU7IA
	JsGwqfxm3xvdBgn+epteqUzGT1URklXOusE96vUUCgrDoG3Ix5sruMrgLgtGrZ1iMjuYLtJZpeE
	Jx+4/rhAo7uObjcMNCg1aKkZoL/wfbVwbe/x4
X-Gm-Gg: ASbGncsFButwwpDiXlZluOnzsDkdzmFoIu1ft3WFS9BEY4CSX2T624RFEIan3BIXAqS
	y978Z0DWR2uOuIPx0I60ZzNmaiPwdO7JgtMBqKSGEoRLa4f6K9CcA5hY5OvP0XMZbAeB7MhFBjY
	e9QvTVMOBdk7vZUnduiCm11lU/sWWsHRlfbKQj
X-Google-Smtp-Source: AGHT+IE17lMcS87AcZdY9lwHljntIGFjrdX/tIws8/mMJWqlvfj4BKIje8AtAeZJAoP34LDD7scalOwGJSBgf3KZaUc=
X-Received: by 2002:a05:6512:118a:b0:549:4a13:3a82 with SMTP id
 2adb3069b0e04-54990e5db47mr6045073e87.21.1741711089888; Tue, 11 Mar 2025
 09:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200212.3294679-1-dualli@chromium.org> <20250303200212.3294679-2-dualli@chromium.org>
 <CAHC9VhRiZS2Dh+0-GqHE+um7T05p4_=EXG7tOtC5pciWMteDDw@mail.gmail.com>
In-Reply-To: <CAHC9VhRiZS2Dh+0-GqHE+um7T05p4_=EXG7tOtC5pciWMteDDw@mail.gmail.com>
From: Li Li <dualli@chromium.org>
Date: Tue, 11 Mar 2025 09:37:59 -0700
X-Gm-Features: AQ5f1Jq-kymgLHVS7YmwSl159Xa7tY4tbyEsovgee_yrgxg5Hu6qlOytWyioff4
Message-ID: <CANBPYPhkYPYGSxhBWbJ2pMqf_iYqNE6H9=ND9ONuTxoPviW=3g@mail.gmail.com>
Subject: Re: [PATCH v16 1/3] lsm, selinux: Add setup_report permission to binder
To: Paul Moore <paul@paul-moore.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, 
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, tweek@google.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, ynaffit@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Mar 3, 2025 at 3:02=E2=80=AFPM Li Li <dualli@chromium.org> wrote:
> >
> > From: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Introduce a new permission "setup_report" to the "binder" class.
> > This persmission controls the ability to set up the binder generic
> > netlink driver to report certain binder transactions.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  include/linux/lsm_hook_defs.h       |  1 +
> >  include/linux/security.h            |  6 ++++++
> >  security/security.c                 | 13 +++++++++++++
> >  security/selinux/hooks.c            |  7 +++++++
> >  security/selinux/include/classmap.h |  3 ++-
> >  5 files changed, 29 insertions(+), 1 deletion(-)
>
> ...
>
> > diff --git a/security/security.c b/security/security.c
> > index 8aa839232c73..382e3bbab215 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct c=
red *from,
> >         return call_int_hook(binder_transfer_file, from, to, file);
> >  }
> >
> > +/**
> > + * security_binder_setup_report() - Check if process allowed to set up=
 binder reports.
>
> Please keep the line length in the LSM and SELinux code to 80
> characters or less.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0d958f38ff9f..2fafa8feafdf 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2092,6 +2092,12 @@ static int selinux_binder_transfer_file(const st=
ruct cred *from,
> >                             &ad);
> >  }
> >
> > +static int selinux_binder_setup_report(const struct cred *to)
> > +{
> > +       return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDE=
R,
> > +                           BINDER__SETUP_REPORT, NULL);
> > +}
>
> There should also be an associated patch{set} against the
> selinux-testsuite to add tests for the binder/setup_report permission
> introduced here.  My apologies if you've already posted one, but I'm
> looking now and I don't see anything either on the lists or on GH.
>
> * https://github.com/SELinuxProject/selinux-testsuite
>
> --
> paul-moore.com

Thank you very much! I'll add such a test, along with other binder
fixes mentioned by Carlos.

