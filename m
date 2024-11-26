Return-Path: <linux-kernel+bounces-421788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F29D9023
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9A628984F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DA6DDA9;
	Tue, 26 Nov 2024 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7W7cMMc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9D79D2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585570; cv=none; b=AFI0lsIpojUWFN3IdBthk5AADkHnSZDh6H7toWVmaAQvw5yh0F2UmgXiWLMNPm3yvs7Wy0hPpoY5LQWFsi2WI6gf1GCJo8HjT99p3a0VYoHXanXK+nB9eLw3MR7tiS15FFWhAktwN3LUpNiWhAvYfHH+oiKVpKLKJpcG1uPfqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585570; c=relaxed/simple;
	bh=v2ZZeeqqoeqVVBwfwGHzwBc28rv9kX8O4U3pgllvZMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AayxSewZyGetG6UZVy5wEcAlmHORto6958T8XPEciLSsaAW47+oVfBpXRzoFc2WIZ56CdoF6ys22L6aT45qDuPRs2Q6JbBV8zFojrFAlcIdBC0TFh8ZOC3drxpeF8UWiG8Ox9QYH5iXW5XeMSb63Rsh2nCXyq7jQkOsAwQPBDKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7W7cMMc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e59746062fso4305111a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585569; x=1733190369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeXIRz+voy9oY0ahmpzmVjvKjLMTGNrTBZYjONA26RI=;
        b=A7W7cMMchXYgh1WzMLCIRkwKC3LyACDe65+hQI0VpjMNp9hCF3Dlvip1cCwgELUCaS
         7dvlNA1fLXRf/xJK4JI/fptnCuCmcpNi3qz7HDPUbKkGVyXVSfRC1TWx0cnyaKYZP1QR
         skd4EuhqztJfKVd6u9uUohOLDGEsrs91cBVMEQw/4jCeBxPToQNECgEWVKgJsR96wZpk
         9HXBT900yAVkKo5tLEVZ1KN2cTpRZsPkEX8tuM8KCMrNphzQkQGXVVNKvdWjfdY/Ld8L
         mLgIXX79JTn1Momh00WZ58cvFleWFVCqqpY63oHbWA4lUsUi5+k7LdntRUjthpB14RN7
         fUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585569; x=1733190369;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeXIRz+voy9oY0ahmpzmVjvKjLMTGNrTBZYjONA26RI=;
        b=MV/pKT2taS3FJIzOggdJvzbyRrTm8uKuwzGCUnhn3cQ8PMDIfcmIDylsbD4WzA9ebt
         r5EMYPFs9kHGZ2LcO9vzCUC5YvQrlJVdZOf1iNMczfjLIWfN2ZUu0xsDCAQlMLXG3khT
         FY9CWP6ngGD1HFKBHJ7mEwlTMveQlrjdMQrLHXv+k7qoNE1yOeiBE+srqy/7OKLg6CmB
         YuR4g7kxIIMTOASdg6ge3j+HOw/139Uj9dARjJRip3yl9ziDKaUcNiOPz3/NTOdVAvUe
         YUn+cjHBHq0TbGShXWWhPq8bmCDV80rFSt5NOLjmws1PQBSGaYsYdKBZQjx4M7EhKiKm
         NvfA==
X-Forwarded-Encrypted: i=1; AJvYcCWMzhJ8y+REFDqEVARsZGkmpAxnLlQMehYBNVgC0/67x6J2+q1xLtEA6QcVSkfiaivXshFCRiJC/EwLiyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkEi1TY+MvS5Fl44IRuOugXOXnGQAgYEprR4bABDuyUc7gttnH
	KgGh3buPdad/djCBxWLLSRbLarrKpClEUu9VYTSx4j6Kvsp6wWY3Fr1rhHnFuqiTEo4EL8PoUt7
	EjCgiBlNSfWa8tBHzPJmVexolsZl7B2WX
X-Gm-Gg: ASbGncuNutV3JYXKxt6yofLrjrqMDOyFlSOKF5yFTbO5+OFjyPiUAyoiJll1dThZJNf
	9jBSAurYOpUN7XOOXrZWYF1vme7gJfA==
X-Google-Smtp-Source: AGHT+IG8EzAshG5okGmZG0whAC5I9ZPfewmJR9vy3whIx2vYnEC0yhECfkL0T9p39NwZgLHb4d1+IfK3/+2wKMMPEMA=
X-Received: by 2002:a17:90b:4c8c:b0:2ea:7755:a108 with SMTP id
 98e67ed59e1d1-2eb0e12c9admr18324964a91.4.1732585568782; Mon, 25 Nov 2024
 17:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 26 Nov 2024 01:45:57 +0000
Message-ID: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> The pull request you sent on Fri, 22 Nov 2024 09:17:47 +0100:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.13
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/ceba6f6f33f29ab838b23a567621b847e527d085

It seems to have a minor merge resolution artefact: iommu_present() now
has a header declaration with no definition.

Thanks,
             Dmitry

