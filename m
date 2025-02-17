Return-Path: <linux-kernel+bounces-517701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA3A3847F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C71884C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE75C603;
	Mon, 17 Feb 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WANR8d1z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573C2185BB;
	Mon, 17 Feb 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798515; cv=none; b=eias7ncqZwz9v93sdN20SQsCCYYrwnK4nD9zcA2bGOGSk1Fw5qyHyddeoy2Ek9DLhLGcgy0S0YZ50RR0arQZHeI+5Q5FW1Qyf3C7xMYQRv6vygyBJbkK2ibrLGQWPkF/DTJh1YpogsywU/wuLWcMpmXMVHkJwF73Xa82gv/BvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798515; c=relaxed/simple;
	bh=fZY5+MxpkCm+wbQpW1TRwuF9fogTCzc2MTVqMxBIRjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5IvPE1SXWlP4BOqn+5YApGLwMXYc1CqlZbjRzheJpZPHN6GqF4dbE/IKkKbBBg0BQPzgqJdwzRQAaS1YVhWBC5DAwhlsC3sytOxy40lWO51o/iFI6J7PQ+khsrhnRNE+/kfXJsfKUStmGLPZpFns06Ucs/76wc8N0cVb1S5VBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WANR8d1z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162b5d2e1fso10501035ad.3;
        Mon, 17 Feb 2025 05:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739798513; x=1740403313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZY5+MxpkCm+wbQpW1TRwuF9fogTCzc2MTVqMxBIRjE=;
        b=WANR8d1zzqEkbJJs7771gurJlGlBmElkY4C/MsIhTdx9uHEp5pCJr9346uBeXdCWGv
         rxQx4tej+U0eryVHY0JqX4pGfQxhohS2Tbsumnqlox8Ax+ZFjBXBk17QSR56vD6ReY02
         jKdNm3v5vsGzD4xj3zoI5MSujXnv9iH4KEEWq0To6B7/Z6Z5B4dwTNRw5OCQfVGn7s/8
         M7gjET32fr9DdNIlkUjokn32cO7SXFuyuddaUY9h1L4naH18/GegfCSw/u7La1ycr+ul
         XT7agdvtSuta8ZYDgHNU+fkirDN8YPHaLu72xdSv6gC7cm+QYFjavwgmPkWXhuu4bRBK
         7L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798513; x=1740403313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZY5+MxpkCm+wbQpW1TRwuF9fogTCzc2MTVqMxBIRjE=;
        b=fpltGBVMlc+KszRQKyb93/SHeklKGDdnnsNBdBv3AGp31ZQf7JUOjYhKcLjf/d92/a
         4ROsj4D5pkNh+4zeUapVZhBBMPSgDbvS6drAmawFv1/n802P60CuPQpg1JO8daj7f7E/
         T6QFVJro74lUHV6QwW+qMBsPP+D3dJ+RiuiXFDgJiCeuNXlwu/ObcvTJ9jvFXdniggYz
         8/gKu2+e93dxhUQ43zDI9mXGzDtYoyi/KZTywlE6gVErNxwFyqFVmcA9reBwoEgHw/Xz
         LeVUE5wR+wCqLRyQuy0wRov6GRanA3zuuB4hnbXE+LJ8cP6jwvHiCL1UfRbqx1cvja2Y
         pHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqmRhbU11b9Y836DdWdDS2aboWDnNSot2F4gGiLZ+PV2UKDz/UBsNCmHWSpAkEcJ5CPQ+tOeaxgI1+Jk1@vger.kernel.org, AJvYcCXYWi6tg3N8/Dnz8/hB/wNfUz0LysVFnOLPBcQyj0Z6h3OTL46gH2/zo9nw2bWhtOsqT7VOomtYsozK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NdkaurGMRVcarD+fx97/FAKj6JhVVI8ciXVVwoSDCfkYIp10
	PZVb7xsEC8QZvIa1UFuUVoRMr5PY+Vc+zDAtciENCPt+PS9zT43jRFhJEm+TU5w=
X-Gm-Gg: ASbGncseBEAoiLdaKZ4b1t0Tszsp4/LADyHTUPzw0X03AO1vn1GESlyNoyDAj1cXCs3
	1gPJzSEtCkHufQu3VLFWj8y4UFPGXfcfEi2Xh1SQZPy2gWHLYVWECi/aRsqRgIJ3jIubDHp02ZT
	1Xy//xYeqR/CRzPopwzOeOIjinO5vZUfoB3C/1lZATzarslDH9Cb7W24DYdQ36eKOy2oEV1mpCO
	w4vSurneHWimkKYMk3Zwdp5EGD5sS//xVjm7GHTHG0P+/z+N/qdrQDrTDo7tQVzAKuZXBGBlR6K
	Zq5HFiB2q7HqyJKgx1UX
X-Google-Smtp-Source: AGHT+IE8azzrvYuY9vtV+dztsz41c/YP2MD1M6ETGEr0TQOLWNYceX9noZ/t3S1swZw5I7fqL8kmaA==
X-Received: by 2002:a17:902:d507:b0:21f:795:8fc0 with SMTP id d9443c01a7336-22103ef20c8mr53951745ad.2.1739798513066;
        Mon, 17 Feb 2025 05:21:53 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf8fsm70994875ad.152.2025.02.17.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:21:52 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: piotr.oniszczuk@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Mon, 17 Feb 2025 21:21:46 +0800
Message-ID: <20250217132146.604090-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <975CFBEF-4E37-41E4-BE3F-7294FE7E4D3F@gmail.com>
References: <975CFBEF-4E37-41E4-BE3F-7294FE7E4D3F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Mon, 17 Feb 2025 10:48:00 +0100, Piotr Oniszczuk wrote:
>I manually installed it on my sd card and sill getting:

I have built a armbian bookworm minimal image, you can test it in case
there are hardware related issues:
http://cdn.haguro.top/share/Armbian-unofficial_25.02.0-trunk_Rock-5-itx_bookworm_edge_6.14.0-rc2_minimal.img.xz

Best regards,
Jianfeng

