Return-Path: <linux-kernel+bounces-231009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1789184DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8614F28C696
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98A186284;
	Wed, 26 Jun 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fggi6UbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564C1850A4;
	Wed, 26 Jun 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413549; cv=none; b=BzCTs5JqEmGRS8SFoqbRyfIQLf4CIBJl1i+PcWe6CqKjpwlpToyuXqm3NSss4b7NHB8sozjjDDQAVCZoKCSUkNWoRmlfQPG8k639Nai0c1q7Y8i65RMQSEBM7aC2liuSyyoeC48AlRxMtxKJjL+tEivrl5jA3wG1Ukn3tZZmHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413549; c=relaxed/simple;
	bh=p+XN+J1QG0TSF6wkOaWsLCfMjOFWbhsblfaxn3Z0HpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzI12Up3cSEt3r6xLmyJDaMMtr4LPkaUdPlMuu/PMgptgiJj5VQDXC/bn0UmHqP0N1l64jCnOr2gddK4zX9nOyycXGPHT93FApYradO+nAyE75kiLrusosaLWj/TEF5/o1FIVgKnh7fgEuWiMKZEeYTYIQGUdWukECFiGTSKeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fggi6UbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C755DC116B1;
	Wed, 26 Jun 2024 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413548;
	bh=p+XN+J1QG0TSF6wkOaWsLCfMjOFWbhsblfaxn3Z0HpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fggi6UbNDcTWa3faSDHuGkwRzdsm0zBrdC7kwTzw/0cPVdMPwwLueasBsM4OgXRmE
	 gHssK8hEkIaNJHv4ZAUeGYSIVlHWjmRaa4ywIUOFtTrImHnwCaLbsIEZquyp6Ncag3
	 PGaPkDOyGO0dZi7avT+imA3Wm/+QZEQTqVUCXExQsvQ7OmUCGtmUdU7tToo8gSsICA
	 sRBAtDbwUXb3Vz48wOIb1aiBcQuDVQnW4VCUysp9yuzfjiV1eWPpo9Rfh/R4mIcwUi
	 WIXNxvxjcMAvJYJLpQW1oprB6iZh1nffmdVPfkJhVs+q0QuxNX72929XbeFfAfBSoy
	 Shf8I0buuqjwA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso5321073e87.3;
        Wed, 26 Jun 2024 07:52:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXem9So5rx5ujYfmTfyBEdLsmgO59NDvaXo0J2fH7E3psVoSd2KHPspvD67QxRAzXlfI1844kkBi3spcNJ4u6F7/1aG69jHNKQ/geT2lAfmAaPqFnoh/T+P8i5jMV1az2+UcdTjV+Z4IQ==
X-Gm-Message-State: AOJu0YxpO7TBO6KYOBqOqOyEYqQEbupOHfPfandmvv4Opklzg0Mc7G9T
	IN/UJM0Nvdvib1wtRSf8yeFvByTHu8BFEzgdKpw44JHNCkWD1UFJ+lYQ1p19s6JfCpqZ1ZnwGXu
	N1TIklahghe7NIK/SjbeBQte4yQ==
X-Google-Smtp-Source: AGHT+IHNvCTNwK4T4lkXJuBvVMBLoM2lndtIpJqaNqZpElj3A9xLin3LwzfuBXbQ5Q4ouUkzu77XmEI6Vpn16RqP/Mk=
X-Received: by 2002:a05:6512:3a2:b0:52c:dc70:ebf8 with SMTP id
 2adb3069b0e04-52ce1834fb5mr6308191e87.19.1719413547191; Wed, 26 Jun 2024
 07:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
 <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com> <CALFa7M8bgVX_L30J72SqZ-0vzfezoJLtZHnKjL-dZki0kMJFoQ@mail.gmail.com>
In-Reply-To: <CALFa7M8bgVX_L30J72SqZ-0vzfezoJLtZHnKjL-dZki0kMJFoQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jun 2024 08:52:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMVKuQfZeU1xEmSQ2QaS1JPd_u5z33r2Ni0qbfzUvH9w@mail.gmail.com>
Message-ID: <CAL_JsqKMVKuQfZeU1xEmSQ2QaS1JPd_u5z33r2Ni0qbfzUvH9w@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
To: Yang Chen <yangchen.openbmc@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jerry.Lin@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 8:02=E2=80=AFAM Yang Chen <yangchen.openbmc@gmail.c=
om> wrote:
>
> On Wed, Jun 26, 2024 at 9:38=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Wed, Jun 26, 2024 at 7:05=E2=80=AFAM Yang Chen <yangchen.openbmc@gma=
il.com> wrote:
> > >
> > > Revise the Linux device tree entry related to Facebook platform Miner=
va
> > > specific devices connected to the Aspeed AST2600 BMC.
> > >
> > > Changelog:
> > > - v1:
> >
> > You already sent v1. This is v2.
> Hi Rob,
>
> I appreciate your reminder. Should I send another patch series and use v3=
?

Not until you have changes on this version.

Rob

