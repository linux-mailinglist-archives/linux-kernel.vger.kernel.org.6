Return-Path: <linux-kernel+bounces-532741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C967A451B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B7017D1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9851494C9;
	Wed, 26 Feb 2025 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKY+3mSd"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EB8C11
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530902; cv=none; b=gMg6NBeOOVehjuhZv8grf2aCfkHcfwbnELQ/0owQEudYKfsj6ZvAAVPGZNFJC/8dqMT8r3RXykMzx9DJ4bU/vrMogZFE4nWLyvh28I/aZ1DuDPgsnPY2U1wVhsg9DCjUEZoBn8TYuwoTn1hWOul6L854YPyeZlI4V5ShBy71zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530902; c=relaxed/simple;
	bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPUG+ap4PfaV2AYnBAi2m5FTMFDyljG9e9IHKiyEX1CQmF9kQ7gv8QvPG5iADlZm275VTJcK8xQJ3UziZeEXEpgYkWCg+k4Ug8UsGuDrrCVDyv+gpb7h/4ieK+F+81nNMFVRb7diUw3vmXNVFaX6ZIooBBr1GICi4rNLjqY296k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKY+3mSd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so55025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740530900; x=1741135700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
        b=SKY+3mSdawY3A7ac1ZdasygcoVtPPJYcjM9c/ywn4eqVNIZyzwYOESS+eQ16Qp7UhT
         NF8ORNsMUOJ0LbQduRpPRnjH913DezHy8bWuCCeDIfDbq9Q3dLDGazspApC8TsCwMVxK
         fBg/q4TQ5Yt2Hb7uL0/AfvTm1A+bXtw5LbTQ74DBE/mLeMQLDuZf8efxSBF2U6b4PGFG
         bqC64c8fqemoKexFnAjk0SRQ2FVJQflskLV8W4BDD1aFP0vuMkmWAqJkrUeLLh3CxrN3
         hv1kp2MY0bcY8jYjfy0sIm9znD6aaR6l1RWveab58W+x34PNs8ePhI3ZazITWGlm/jbL
         afuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530900; x=1741135700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G/3+m/lRjbsgB6Uj67QoFbCFOBM3izr4BbRlnuiWfc=;
        b=YMJE31O6BC3DmtlvxlPhUNlvxakTipJiwksed45BbG/Oy4X0lYmicQo3yHgvaT4kft
         fvl4kQRrki6dHBaHZoiYNytohr3DkS7bUi2C4hNv570sibfibd005waxwMfu/zeEKA6E
         op3UqsidBdfmLRQt1PsN5eJnQAdPtunNxpCEnpRkw0n94dNkUsGwGYG3k5UMDXZGQl/8
         QqfkSLADGrxDMM/+F0ZEZQ0qMBrdbB1ZJW7iD4Ja+SAbaw7R7Rv2FSxVH2B18/ElLPyL
         ax5BmuuO4Q7AeR9DN8pedxnYPXFiHiaupTbNmM2qqensQ+cv0ETHT5KLeJ9Ur7o1HGgr
         ujFw==
X-Forwarded-Encrypted: i=1; AJvYcCW6+m25n9gK3M4AC0jj1XBLIrAb2AkqtTL2V8QwJZ7yoRSsvn9Ax3ujCrn0VpIeIhd3F48xQLxLzzjdVrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BsguTyE+ab2xeS738ulqAxfPh92n0mjNtv3oUmkFpi6INApN
	eMW6WyLoaoe9wdMsA3gN7TpCNR+caoYBfBlMBSZQxlmLvhCLPdduWg9+YMnJaDdd0jcckw1YLn7
	4z6vMrXD2nFmgPLiaW0FpR6EAusQNMeCdGJh9d2MzV5JVAD9c3hxP
X-Gm-Gg: ASbGncuEnzv4qcRM5GHI2htzVpke72Ig4oktxT++OCR8CoSUzuPTdaVa0BbQChmJON0
	ENoIh6cGfOOVr+psRpHgnPyNomaxFQ5192ceWumr4SjfRtnQnUV8RNObWTUvMhsu0mC7DacYu3Y
	oeNqruBa9hP5K19fefs+IeJfxJIs9tO6zzHB7ngQ==
X-Google-Smtp-Source: AGHT+IEonmoXFq+Ql657Kw6dLSY0rgGUEYIF0fLPMaaamVLsEFg6KhJOepe80hFReyd4EBHGAz+Lg9VVLfRxSPLAzbw=
X-Received: by 2002:a05:6e02:3dc4:b0:3d0:507f:38dd with SMTP id
 e9e14a558f8ab-3d3048be45fmr6716235ab.5.1740530900058; Tue, 25 Feb 2025
 16:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
 <20250217114831.3225970-4-kevin_chen@aspeedtech.com> <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
 <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com> <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
In-Reply-To: <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
From: Mo Elbadry <elbadrym@google.com>
Date: Tue, 25 Feb 2025 16:48:09 -0800
X-Gm-Features: AQ5f1Jrgg80yi8orSiI63M_RmdhldZtwHc2ZYNn_1MdwWw5j1deSt788HIVdze8
Message-ID: <CAOO6b=s4CyVvCP8Gb_OGWCMX3ggs9sm6_WnqEB1h6ScVVJppDQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au" <joel@jms.id.au>, 
	Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tomer.maimon" <tomer.maimon@nuvoton.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Jenmin Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Understood, your comments do make sense and are the right way to go.

I agree on not rushing, we want to see things moving forward but
properly as well.

Thank you for your help,
Mo



On Tue, Feb 25, 2025 at 3:28=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Mo,
>
> On Mon, 2025-02-24 at 20:34 -0800, Mo Elbadry wrote:
> > Hi Andrew,
> >
> > I agree that a small layer of abstraction is needed to provide common
> > chardev semantics to userspace. I think that effort can come where both
> > Nuvoton and Aspeed unify their design and agree on a common abstraction
> > layer.
> >
> > I think such efforts may take some time for both to unify, is it possib=
le
> > to get this upstreamed (after addressing all other comments) while both
> > parties work on an agreed unified abstraction layer?
> >
>
> Given Arnd doesn't want bespoke userspace interfaces in the SoC drivers
> this will need to go elsewhere, perhaps drivers/char or drivers/misc.
> Greg and Arnd maintain both, so the patch needs to make a convincing
> argument to them. For my part, my comments are just opinions based on
> my understanding of the use-cases and the SoCs involved, and the desire
> for reasonable devicetree and userspace interfaces.
>
> I don't think it's right to try to rush things as devicetree and
> userspace interfaces can be tricky to change or remove. Rushing tends
> to be painful for all involved in the long run.
>
> Cheers,
>
> Andrew

