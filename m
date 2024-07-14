Return-Path: <linux-kernel+bounces-251790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255F9309DA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 14:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB44C1F215CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC01073457;
	Sun, 14 Jul 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jheh/Nac"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D94E21A0B;
	Sun, 14 Jul 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720958665; cv=none; b=jYKMl7aIFXMhNmhuotU+lyB3PUJgAwZ2T4ZQ2sp2I1LuapgkKbdj1qoS5wyR0Ny18v37SyYeCp4Mv3yPGR6KGqxA3hXFzOCFn1w2cmLIReNyi9GUdKrHuvJWAdtvcrmJyQQnkfkNIXCKvUWlC7VCIcKMHLuoAiGcNs/WAXU2pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720958665; c=relaxed/simple;
	bh=0UNSlpIkJhLpDLHXYNSh1P1ySY3tU4A2NnQLSN8UsTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nptFy72jQ7akhvFaJ42IeH4tS000n95J81aKAMJ34RDGza6BE23OdmFIQZYqpu/HQP1dur8oY1hLm1N1xTFkFK11Pi48aNOjd91Y1dTRDeArxrbwgpBTUcStq3PjOiYpJPjORV3xqeZok9HhZas71whYWMR5yui5JueQThGTHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jheh/Nac; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36799a67d9cso2723507f8f.0;
        Sun, 14 Jul 2024 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720958662; x=1721563462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UNSlpIkJhLpDLHXYNSh1P1ySY3tU4A2NnQLSN8UsTI=;
        b=jheh/NacOxGXPhnsjxOYBxkA1w3nRfPGUfkCnYE7ri0oRnhXkG3VKCquLzs63Dcan5
         E6WAJlscRyKU96umilLlkCxYkGMfzuRZA59/Z6GA7JBSqRhtSix0bblk5hSbQJMorjI1
         pbYHQqYVCWORzMeiHd0mO7w/vRHKII2REOGNw3RhFM3ifuEW6zlU846H38vvgpWLm1Ic
         X+hyGuAIYRFgdFwDEtqe1HIcyHBxaOD8731SYRx3nxbPglmVErZFvtReWW2X3ko3h2BS
         bBLBQPAcvrBKeOImv2YoUW43K4kyCz22qqRXagWsVM33Dx9U1YJ7uMEJRwOF/KMZj6kc
         e2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720958662; x=1721563462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UNSlpIkJhLpDLHXYNSh1P1ySY3tU4A2NnQLSN8UsTI=;
        b=DCDzlPN2FJtNLmwuMWt19rhH/N3abc47Yj28oQheFKQ/Z6qMffKiTL6/FcYo2/TixP
         W/ebBzHoi4p6+7QDoY53SOUkJZud8rQ3HebQkuFB34J+nUVfYrn4toCdganxWZsxqsi7
         jWiRjgxxhETcegJZc14P2Y0Lk0KeVgj9PmBp5Nz/j9cvBK24fAO5vUWQY3fVnI1dxzdH
         yZVss6x2fhlB1qd8tBGlggK0HbxmY+1+QsR/UWs8PZpuwQMmVD0KzmS5IrsWRVmzogYJ
         bvpQ3npmeW+yyaC0be/f12cl3wFiGYwOUTVWmeMJ/WUnzbQBzAeD1ee6DPIAm4nqIgzI
         /rLA==
X-Forwarded-Encrypted: i=1; AJvYcCUSbj7LWx6JAITrrLYeRVF8iPdlUSjKUnIBnNmoGn3/q4EdeFdXlS0AOGRZvK2D/OaQJVtfxh+dopmyvqQZlilq9JfHY+YxO4lkJ99u
X-Gm-Message-State: AOJu0YyfwQYnEBnzL4Pb7oQpxzDDPgYlydWH380QOeqE9rquFhm1nXia
	7MvQ3ifwbm6C/pFkrTdNmc9OJML7iVBh2d56+SNA6N53kl+PrcKNQ6y7RQ==
X-Google-Smtp-Source: AGHT+IHXvSq8+dvaGcFJfUPSHPep0518YOuR8EkkEiNydebhijVQBRNrFO1KuLgU9169QYUODZyZ3w==
X-Received: by 2002:a05:6000:d04:b0:367:92c7:3ac0 with SMTP id ffacd0b85a97d-367cea6c063mr13228222f8f.22.1720958661778;
        Sun, 14 Jul 2024 05:04:21 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb979sm3691236f8f.75.2024.07.14.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:04:21 -0700 (PDT)
Date: Sun, 14 Jul 2024 14:04:19 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: sprd: sc2731: correct interrupt-cells
 value to 2
Message-ID: <ZpO+w+Jf+Lt+ngqK@standask-GA-A55M-S2HP>
References: <cover.1720957783.git.stano.jakubek@gmail.com>
 <6ae55300b0915fea4ad6cc533b84815eb3cb8043.1720957783.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae55300b0915fea4ad6cc533b84815eb3cb8043.1720957783.git.stano.jakubek@gmail.com>

Hi all,

you can most likely disregard this patch, according to [1], the correct
value is actually 1. I'll fix up the bindings during conversion, which I'll
be sending soon.

The second patch should be good.

Sorry for the noise,
Stanislav

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/sprd/sc2731.dtsi?h=v6.9&id=5863dbe071caabe752ce6f9f6782fa03914527ab

