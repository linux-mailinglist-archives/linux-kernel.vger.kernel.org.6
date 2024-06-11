Return-Path: <linux-kernel+bounces-209742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5084903A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9504B285DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A917B419;
	Tue, 11 Jun 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX98tjQv"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8D17545;
	Tue, 11 Jun 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105530; cv=none; b=uK73vhTQBvUhXv9AastNDKNd+TpEmayS+OZ53nwFjhjeZmHxts3485UNruHkoyuVa7y8xwK55LxxhmJtarVLMauDMHuZQc5FBImT74qzckJH3ldwo0e9+3uX6aqbjh6MAj2OlN8UXY2ArfMN8zSPNw0JOd55NEqjWh5SHBuRH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105530; c=relaxed/simple;
	bh=5QhOS7T2ECWOrmqZP7wpgVuK7sIW+K19WolJgjf0mbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxY+2kXvsh+Li3bogGyckoeoZ3l2s6y8VPxPFe6dooWES53cyepazyYk0EPTAWAJSuQ5OSJpdmRsCsW+hgulnjAMWdeimvFK07Qnc2BudnNHjAswxeL8gZafW78rI09M5sm5jywpkrhSkc3m2x99ZBwhMK5xT+7yV9yUWkJZsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX98tjQv; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b3241373adso506895eaf.2;
        Tue, 11 Jun 2024 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718105528; x=1718710328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo2PmNsaAKgRZzuMPm5GrqXgFAxK9fkcVAgK1ivuWd8=;
        b=bX98tjQv3G1ZUs16ZruusKfyotrUlaojCEwYVHeRnX42x/830Bngw0sPHf7hSMtLTG
         7NYLZS9VfNsOw6BRkYO+SFnnzp/LuZxUMnDXb5JgPsDC6+cOA6KxP9vSE1aUZEw3SBCm
         g79GqcIrYGdKN1dG/iufZFXd3XX3+3T6SJZnFYY0hnake4eyF/J5juUQ4VsRAr2FPDXg
         IZs7Dd9Gv5t53t0UUxmenJ8K7z/9k7cYkbRuDVJdASDsCwkZkZR6npDTqDgcKU9g9HGg
         ZbziuacFvKARrL2+KkvY9rQpJ8hJ7eGsdf+nwDI4Bu0VggLZ9ipQ1PlppFWvaqZKiqMA
         72ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718105528; x=1718710328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo2PmNsaAKgRZzuMPm5GrqXgFAxK9fkcVAgK1ivuWd8=;
        b=NSzzun7IN4+Oi+1pLEgJAxN0o0LgCuBiDAmJMqDZDjAKSLew/9Oa17H6H1Dkv2mjHi
         kA/wo6UX6eCnod7klAgzCt08xdRi3j6QXpjaXlv15zXjReqUVgxzKpxagP9ku0nulYJx
         g0/vjFdeZjWcTSlTp5B3E4Qmaa55zuUbNrhHbYNWaLGBmFcAbLYsSuc2YiOR3v7LkLpJ
         3Qdf8IhCf5yymYXocUvpW76kodf1jjIZjVZY1Vd6Q1GSVIku4dEw2u1P/Lx2Cd3xn8bE
         flwtUWbi/YQAVdP7m/OzJNnNADWNfvjEcOH1CTQ+9lF/bEbi9VX6BCkMIJ262N7UStMm
         PV0g==
X-Forwarded-Encrypted: i=1; AJvYcCWo9ZJuMLhdIUq6yWBL8n1++SyUWiLvpnG9EmLr5wjD8mesZJyIrH3V51N0Kf0bui6b6ork+R4aPKeCwkfblq2DLnxzL5BMH9kmEIGnNw5trFTBgrJOmh+14b0GHkvhTIz17kkwj9ig
X-Gm-Message-State: AOJu0YyBHDFO6zVrzJykf+duBgi2FV+l4xXq+Mm0bEpc/7X7VVA5q3H5
	QZlryCa4PGk+cGZKjKzU+yyD6ES5ilNOu0mx1/KmAFgVM0F/YDraA7993B9QkzlPgsMKYRfwme+
	0qBy4scbBnidFQCaAqBTvcNmhsuM=
X-Google-Smtp-Source: AGHT+IEOXcemW3CJq1WccB0TeUKL64I1iCoFXp10rVnF2Ye6L9IJ6w7VZS1vjuiE1ZhFLQiRKTceR8mn+/Hpgl9lPgY=
X-Received: by 2002:a05:6820:1506:b0:5ba:a69f:465f with SMTP id
 006d021491bc7-5baae8d7912mr11170277eaf.9.1718105528139; Tue, 11 Jun 2024
 04:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611042515.61387-1-dzm91@hust.edu.cn> <3931f2be-fe98-45ac-8a40-a474dd7ef61c@loongson.cn>
In-Reply-To: <3931f2be-fe98-45ac-8a40-a474dd7ef61c@loongson.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 11 Jun 2024 19:31:41 +0800
Message-ID: <CAD-N9QVbU=+i2WH05-836TNB-G42R3NQWf+8OFxfsbrbFsd7cw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: add process/researcher-guidelines Chinese translation
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:11=E2=80=AFPM Yanteng Si <siyanteng@loongson.cn> =
wrote:
>
> Hi all,
>
> =E5=9C=A8 2024/6/11 12:25, Dongliang Mu =E5=86=99=E9=81=93:
> > Finish the translation of researcher-guidelines and add it to the
> > index file.
>
> How about add a tag?  just like:
>
> Commit xxxxxxxxxxxx ("xxxxxxxx").
>
> This will reduce the effort of subsequent document updates.
>
> At the same time, I also noticed that Ziqiu sent an automated probe
> tool, and I think this will be useful for running scripts in the future.
> What do you think?
>

This is a good idea. Maybe I can add a sentence like this,

"Update to commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to
RV docs")"

It can help track the translation status of all translated documents.

> See <https://lore.kernel.org/linux-doc/20240422065822.1441611-1-chengziqi=
u@hust.edu.cn/>
>
> Thanks,
> Yanteng
>
>
>

