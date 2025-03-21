Return-Path: <linux-kernel+bounces-571567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928DCA6BED3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57107A3AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7080216E01;
	Fri, 21 Mar 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TBNxRapp"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB011F12F8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572519; cv=none; b=mtvEjGfJ+M7Kzr8VSPfAQXLPbHd8vEjYlDjv0BtUG1nTFC2SkzMtVtsd26sBrfaTdshgx3D9ZoO3xvzpVAGry+5SW3twNRH/c7GjaHFqupoF+/7hRyspKSAd6gI8I+/nDNn3h60nmCou4J4z77E9JD3UtATzaLuNuL9laF/qGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572519; c=relaxed/simple;
	bh=1wNtXhel12/P9++f5zzCWHX9NzteKr/42/osDVNIPRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QprxMgk69S10Zxc0OPwlcrdhh1VdOZlI/E+0lhmEh5RMdZ0LM7y6kN2v3dT9sG7A4m0IlX3bVVH0+AoZTGXDelUocACa78cKXilnJ6zUMnEk1lkj6Q/bx9C0Pm8zG+k7MZOlN0+Dk7AGR9i20Sb7PMfWs4r487vjOJg6LAqtcmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TBNxRapp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso10245065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742572516; x=1743177316; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=keE5UAE8I7WQVpj+EG1JG1WPFCAgkdvUmiHSr+M5kNk=;
        b=TBNxRappCOi0ACvBXxjn5U2IBBHAuGlU1bWnqocxQFM3u7ck/pq9twTGJyayywwNBV
         XTdYLYdpEC3J0/9I2ilxeFpVobkOe1Nvj6FgwRtd9Tdeacjbm4O/uwYUKbdXE1oXkx+T
         ArD7IDUcz3KxadmoKFANu+mSZ+20lixUXTJ4/tJb43RnY3S6m0KDkF1OwDsYn9iSfUc2
         kZgGzZj5vSjGMJ029vb5sc1n3FU8abrE9hZavgwX32UKHJk2aITP/es3cZe+fJL669Q6
         G//pHczpmOEiI5xbAYQSw+DsKNG6vO6PClKE2P7DHuvlr1Dgx+ZQ/uBg0+47JMZL9rQH
         C0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572516; x=1743177316;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keE5UAE8I7WQVpj+EG1JG1WPFCAgkdvUmiHSr+M5kNk=;
        b=dgBgp8UPUvAKf/EUb6Fgrzfi5hj8N4IWi8Z9B6Npli+sOcGDBICqZBb2A5WMFZoTHh
         SK75wHRa56nqd+nfxCXeAogxoBzCE2dKCAbcMo3WiNKvs7ndR+CTIv6TGmjOUgvwQGzY
         Nz0RFFha1G//pCFiDH9GZDq+nYPbkPNrUJTYgAHYtUDNyI2Z9Pm5olXdGjdJhvZbZLSb
         2PBL5ivVEcaik84XA21VYtMjM77UWQitF4vgsJJ2/bDDhv/mh8+hzb/X1zpyfCZyqlia
         awE0bYRDwGmt7jHSbDqjke9hVC9FKeDtaSJ21q0pFcoD774Aw9wwgGyNDQ+Xg43imWAW
         c3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWRW6fgreJ7rXWFoafdlGsy6d1bsekkiMzqHcUrXr14DehZtDqCwVta+7/H/rVjNz1DHqj4iXE/JYSQrjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx572jtiB275xdM9/NliFq+4Kg3pIG26iYgiz3OmhpPjEUAY4t5
	Bk/eSzGrZmp/8SYbNXk9SD1ThwoI6nZ1aPe+kYeeis78VRptnsAIobAd//sIBGlAJkf+SZBw0/e
	GOsw=
X-Gm-Gg: ASbGncsKn8dQrjCTvx4NoKyANJDbl2Q3UdhUey3ilQhiV7ckwkxXaSb9OHuvWT6buvL
	Us8rx+0/dhbtxko70KmDfcApjPitboO1Kg55LNG7Yy4UGRPhfOSA9r55f7l+s/I7SU29Y3VNw1K
	Tb9rG0sD3HVWFZ4OalCR06lWZLAie+a7HRxAq71io0wqFq2Yz+l/NYtCamzazkSWihFvxhyK85o
	xAPyLiVCbhEJ0aFhk9JDsDZz62u19RBbUqKAbwJQhlbUIwIDk4AZ6b4nNNjhpLOy0dm0/0jNB1N
	/F0KnBAhhyjMTScRKeruEMuWBg8PDfjtd/7Z83bEXGNFNxoNJAlMcFk=
X-Google-Smtp-Source: AGHT+IGf7f6p3B2QWzXbSlTw1NK0pPjUROlEz/T5BuJywHA6Cp2/lY5juGyE3geEn0WI2gDMWjaauQ==
X-Received: by 2002:a05:600c:198a:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-43d52376b88mr29455795e9.23.1742572515585;
        Fri, 21 Mar 2025 08:55:15 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2102:ce42:30c0:9b40])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f3328bsm81162415e9.1.2025.03.21.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:55:15 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: amlogic: drop clk_regmap tables
In-Reply-To: <1j7c4i2xq5.fsf@starbuckisacylon.baylibre.com> (Jerome Brunet's
	message of "Fri, 21 Mar 2025 16:46:10 +0100")
References: <20241220-amlogic-clk-drop-clk-regmap-tables-v1-0-96dd657cbfbd@baylibre.com>
	<20241220-amlogic-clk-drop-clk-regmap-tables-v1-2-96dd657cbfbd@baylibre.com>
	<9f1d69ebe1ddce5dfc170e986c9213f2.sboyd@kernel.org>
	<1ja5cp8f87.fsf@starbuckisacylon.baylibre.com>
	<88fe909ab182d1f17f6ef18161c7f064.sboyd@kernel.org>
	<1jfrlwb69r.fsf@starbuckisacylon.baylibre.com>
	<ed20c67e7d1a91d7fd8b921f156f56fb.sboyd@kernel.org>
	<1jmsg2adgu.fsf@starbuckisacylon.baylibre.com>
	<697b634770d789ef8ff0e05cec9465f5.sboyd@kernel.org>
	<1j4j205ark.fsf@starbuckisacylon.baylibre.com>
	<5109de7fe1a1a8467118daf80c7b7f8a.sboyd@kernel.org>
	<1j7c4i2xq5.fsf@starbuckisacylon.baylibre.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 16:55:14 +0100
Message-ID: <1j1puq2xb1.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 21 Mar 2025 at 16:46, Jerome Brunet <jbrunet@baylibre.com> wrote:

>>> 
>>> I admit this is heavily inspired by how devres works :) but it does solve
>>> the early clock controller problem and does not scale with the number of
>>> clock registered.
>>> 
>>
>> I don't know if devres is a good model. It's about tracking allocations
>> and things to undo later, not really to track things to do when called
>> initially.
>
> My point was more the decoupling it allows.
> Maybe it is me being too picky, but what I'm trying to do is related to the
> clock type, so it bothers me when it scales with the number of instances
> instead of the type.
>
> More generally, something devres-like allows to register an attribute
> and link it to a group. Then the group members come and just pick what
> they need. Whatever manages the attribute does not have to track
> them. That is pretty much aligned with what I'm trying to do.

Just to be clear, this idea is meant to live in /drivers/clk/meson, for
a start a least, not as something generic.

-- 
Jerome

