Return-Path: <linux-kernel+bounces-560486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4285A6054E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EA13BF80E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168FF1F9F7A;
	Thu, 13 Mar 2025 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfsOlFpb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F031F8BDA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908556; cv=none; b=sVIK4JETaejTCFfg+W1U9C8oANKyV62QbY1OJfd8u9+5ymEeQcggO7rJxuLvMBtSjl7lKBh8wP2VFsnPe5hhCF72t4+GtvNBNJdSt2jkd3vDgnTRehzJUhsKnV2E57E5uaW3L9gFmBPcl1MEienQTvWvXOLZyEi2Squb2rhabdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908556; c=relaxed/simple;
	bh=fLmgjAemiovWofaWjxUzmEbQJocXHzEtlxZq33BB5yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhUuAkyQJV69KyINboULBBe88iVV8q28NGnDzxix1Q2x8MYqXtVGs8Ke9azGvo2JEoEG7n6ibE/gePJExDzcOZZ1WczmBPE7DpBSEPdUvPGkfCogRa1ZbuYCtQmMMo/CnyGbtQ21opdxtRoQHLQcZObHUyEV+y70HCEeT+Nyogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfsOlFpb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4679562a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908553; x=1742513353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLmgjAemiovWofaWjxUzmEbQJocXHzEtlxZq33BB5yw=;
        b=lfsOlFpbTPBRbIvsQsXstONyoujQ9WYBfAVAZDm8fj5yVu302FMqndYW63WGKRacz8
         Wob56WUv7RiopHEgwubaiTQNz7LGH60lnhU5zQojeTU5bZkxrwnBzY8sV8YkOYKJnujS
         Vo9NS93Y2QEvc9w+xlXp/LPpEicdxWIwSvVqg0/SUx9TJ8YyuoQewMhnTvUiAIB1OKqH
         28U7fr59mMsddTJpya9PXaQNpmyylQwTAxeSjmTcfBXc2Q5ZF21OD3qYH+f9j7tHG8F5
         ZmggM9cUgqkSSDuKqVWK5kGTvua7OX2uHf5lm/gvdrHExalE0kAWJzwIL5jcWFYXog6Y
         8Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908553; x=1742513353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLmgjAemiovWofaWjxUzmEbQJocXHzEtlxZq33BB5yw=;
        b=Xd+lPkankVJBp9xmqKUbe4nQ3GU7seAESiXl9RIYxQ16Ti3wvZsNgQ4U9u5Ifx1/0m
         e1YqWdzTAI13VV9NnjOxrRqWGtcj37IeyrfcpRwebdimRFSq6szzJMiQshNuNDQXbHhG
         kPi/H8+Bua19s4zpr5hpuCNsrRbATwO2uXV/JijZkauK2wCEAr0vsA3rQ0QZcJ/QXUJw
         Phm9m3KYkZ5a0wzrMS79+F5w1UsOjkym48vvind6bLzIm1FnSTWB7sqvsr6MXNvyhbPK
         IvvaKmMcCbJlRG+NX7q4dXDRFf88LOa8I3pCOg7PY6v8FAELZOjS1W3Of+eNJalenGUh
         vYjw==
X-Forwarded-Encrypted: i=1; AJvYcCW9jRIBJ2r6r38gSp/DGUbZsP1OEXi1QLbJCp09CMz2ir1Mwepk7ggkRPCZAn6XpqF+X6Q6RaCT7QrZIjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIR5xP60ekhWRrY2Rhh/WhVVZ66qqlrT8bqtfIfjn03VeFt3WE
	fkQh/iCnOX0VwU8cMWAdYY1eYeuNI6NiUptH9oDhE685eeA4dTIzUl5cvlD3GNiAkUs1JAmTwR4
	coIGxxBL1jT+MQ2V+mcf29GgfjbsGlDnOqUo7
X-Gm-Gg: ASbGnct8R7Qw1EBgQsBae72kSr2NTGttJgx30TBK6vxJrlz9UGQVvMXU1g0d1yubQ58
	Ta95gQqzesm1j7zv2ca9yMkrAxYCFVoehnbQpLoYnSEqH/j1AfDRHZtld8rz8SgJWZElLIb2c4c
	PvUZJNMJv0PWwOWN6UbX66I7m3JLoj1YisXAfEWwFP/JrnO00KK9gDpE/uBLSwrARDJQ==
X-Google-Smtp-Source: AGHT+IEhG6Uj2ZgXODFDQkPgzEVnFaKEkMeOMCOgSAKxsS7ffAl3Oika6RfeExnwIHlB01YBUlfrm+cZgMXZ8GfGSBI=
X-Received: by 2002:a17:907:6ea9:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac330de660fmr24794366b.0.1741908552998; Thu, 13 Mar 2025
 16:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312195951.1579682-4-jthies@google.com> <202503132357.RnlF5A0E-lkp@intel.com>
In-Reply-To: <202503132357.RnlF5A0E-lkp@intel.com>
From: Jameson Thies <jthies@google.com>
Date: Thu, 13 Mar 2025 16:29:01 -0700
X-Gm-Features: AQ5f1JrveV3I6ofpSQly6Maa1d3lFcNQ3Xq7VBo9SbjQm6kMIPtOwMRmVpnj6fw
Message-ID: <CAMFSARdJgVQitDWmszbhSiVfu4hCoyyNVj3LPHb+7wq64C1BiA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
To: kernel test robot <lkp@intel.com>
Cc: tzungbi@kernel.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org, swboyd@chromium.org, 
	akuchynski@chromium.org, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Echoing my response on patch 1/3, thank you for taking a look at this.
I=E2=80=99ll follow up with a v2 series to address your comments and resolv=
e
the build issues. Additional responses below.

> > devices will be created automatically. None of parent devices should
> > ever check if the child exist to create a child - it makes no sense.
>
> This is still valid - none of parents should be poking around to see if
> there is a child or not. The core handles it, DT handles it etc.
>

Understood, we can remove this for DT. We need to keep part of this
check for ACPI because there are platforms which need this driver and
haven't defined proper ACPI nodes in their FW to load cros_ec_ucsi.

Thanks,
Jameson

