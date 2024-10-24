Return-Path: <linux-kernel+bounces-379064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E319AD92E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2621F22FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6112744C;
	Thu, 24 Oct 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVS/P8Ic"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AC38F83;
	Thu, 24 Oct 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733122; cv=none; b=o8yVFJCCbBMKa1NlxQqFfFMERsxW3BSKjc1930i+f1/unh15fTUFnI31aNpWtzjaZys9UCXUdL3JtU/8wAQbPBwZO6EwunzmPDIF8nLT/V1S5Yr1N3FK8hwuMjo68AbOiRE/+8av80GZ8TUMep3wQvP8QDvSPPznI0r6uXqdBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733122; c=relaxed/simple;
	bh=HZAjDepNGFjniRITjLSU2iycvb8R5mnw6oTUxwBl2lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6vKqw5YUqQbpx4x+l2mAq1UAQhMxeQdjH40oSDAAe1qi/q9BUA5ud/dYKU+zBg8628Zuhr71NsRt9x/MiCLy0Whm6u1mmzHUPlgr7Ug3oKsICJ3CzmHw28q/XGfVN4vdg077jq0np4gIe97a84/sgK5BNg6YrNHiXri7mtZ8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVS/P8Ic; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc0dbc566so196741eaf.3;
        Wed, 23 Oct 2024 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729733120; x=1730337920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZAjDepNGFjniRITjLSU2iycvb8R5mnw6oTUxwBl2lE=;
        b=iVS/P8IcqvZcGueVADBba22R9wQedv7OrXOQE2vwoRHBk8WjJ9i6HupW6cO0ERhSye
         cpReESPtSYwoFs7Pu260jf37BcpY67m9EK64IQV5Ag+nZc7s5ACJy2BMEhuBig+tdJIt
         NI1WfDFOIQyH6YvhOdGxwebzIJXpdYee4lyVuxFMdLJQAqPg8J+EU92tcjEFk2clzQF3
         h51HSBNZWes12GpRbt+BJO842WFWJi3vksFYhSxaMzf5tlC9i5WopJJiBn662oDYPRDT
         FnTWHsBI2VYdEAP7Z8bI6/oeWkLtn855Z7tIwGz5BTOuoyqi0EcslqnrQJgUi7iTBkDM
         a+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729733120; x=1730337920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZAjDepNGFjniRITjLSU2iycvb8R5mnw6oTUxwBl2lE=;
        b=vRxL7udi+6nefZJlKjD5olxmHg0K1jPDWNu8iDDDsbl6HUPw0v76rhkIiUYUk4xSEU
         ISV8SiSJorPI1hBUEQSnv7yPeXbtCZ1L5kipXRXKyDQ8MHYaq2Ix/27/yoEuI0htigkI
         fCiR2UhqpjsMMsH7SXDkH5Zkk/8WnP9d1MkwSJk3wJC3CfmGTZGk41uye2bDbq9l4PR6
         /X/AZU+o4rJ06Emo3JCHgICiveP1QnCRMWvdz8hT1X7GgGwDUOYaIf/+aFEvh4v3CsV6
         JD2vPGMAyeRtWFDuYivOG6Q1kiKQEQZ86HLpb/obMVUkYuaiYTKRZWmtXrfcLYKlwwsL
         VaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8h5Q68J8jcjuoCBsVwLQxGVN6Aoj1yUfiwdKNbFf7yw7GCopDnrBfdU9gfHt2TfSGJ/s27kfIxisG0cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV14UBrFEo6WwYEiDViQVsu2I9svdjPDBxIWIgIB7BpOlay87n
	FzRMHqgGDrc9/pOQs4rDlcc9cnI4drM8maSHX6dlx0+l3dA4sKrW/Wnzt/sNUJTYrTSHC7dWdAt
	r3a5k2zgJG+nyaURyng8TegGeW+c=
X-Google-Smtp-Source: AGHT+IEdFC3TFHl6lmnWSoJZ4aB76VAm3Z/sbzQHoTIF9FUX4iGpl9fBFnU0npT9FupKp5yBmEEHDF3b94xrOGJlA6A=
X-Received: by 2002:a05:6870:89a4:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-28ced44c158mr229864fac.36.1729733119848; Wed, 23 Oct 2024
 18:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023201334.250764-1-mezin.alexander@gmail.com> <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net>
In-Reply-To: <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net>
From: Aleksandr Mezin <mezin.alexander@gmail.com>
Date: Thu, 24 Oct 2024 04:25:08 +0300
Message-ID: <CADnvcf++bWv=Ohwc=dwSA-Hy5_G3jNS5hjWgA_-yx5HSiS1f4A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonas Malaco <jonas@protocubo.io>, Aleksa Savic <savicaleksa83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:03=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:

> I will not accept political statements into the hwmon subsystem.
> Please chose a different description.

Could you remove me correctly with a patch description that you like,
please? I can't make up anything good-looking and non-political. And
I'm not going to submit any patches anymore. Sorry.

