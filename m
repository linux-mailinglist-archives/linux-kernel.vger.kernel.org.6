Return-Path: <linux-kernel+bounces-201040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611A8FB87E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A80286CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94501482FC;
	Tue,  4 Jun 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO1Js1NM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A117597
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517221; cv=none; b=mjL2w56wtxZuiPY3UXzwevYyucASmQNDW+fkpGJLkWIxkYprnZxxXUXnR2iqdQtGn9F+qQgnYYWTkpI+5B34GBqFjqjGBW32JdQXoFN5FLdAM0aMVihgMRclICq2zx0dbwXCZSJTOA0Hh9T+L7KfPhSHJGRUVbuByzhelVOnD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517221; c=relaxed/simple;
	bh=GfgdfxzT8n8+FRMuhvSXa/oYSlEgqKTOgyJud5hAWa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LaMPGTYwLL54bGn8fy4RY8dIP0mhnJR7TgHxfAPHfxMec/0KJ9JfbbwyqRHrCd+v55LKT9Jvx5caYPwXoz9pyIuNGZKvQM69UBUd1TwLOPxW/1diRTUrGZcc5hVx9a/O2RwoAKuJ9d2q46sayduO/CnEi+OH6VF/jRSREBXk0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EO1Js1NM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso5899813f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717517218; x=1718122018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVcQEIP+MENTssUPsqaOZqlKvsqibx0etjqeiTYhCrQ=;
        b=EO1Js1NMIsReXNE7qOnijnyWw/z4jZLzVaGj7Pi5pzOukmCJpNpPiAcQSgftiYgxyL
         BoYMdEAh8twkkSI0bHzaYEureehs9I/wQ/ZwHSSSFDPlmKHmND4MvQD2tntGROB1UGAt
         LF1BSqvL4QARxwREwSfjgf05pBUzWvwGd9i+6H6jKw4+o2hcbNXYqAWW+jyxi5TBWwUS
         uP7E/6QsI8288rWxFZ9J5tF5qyXGrUX1OrL9HzUwDN9wHw6VwCuo9J8s2nHZXDhrm6P5
         4QR8/N69eyMubvCyIlW9Qp5bvQQh4P+O130Sk3+rV5Oe/iiWlpYiC8EMZW/hf2y0wl0m
         CbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517218; x=1718122018;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVcQEIP+MENTssUPsqaOZqlKvsqibx0etjqeiTYhCrQ=;
        b=X/snfSDJzlqZaeIxcJ+o5jG9Lb75BHjvSelzkKWAZKkz+xHfYNK2iFHnL+H+rC1yUn
         3sPIATJhWwBFRR/nhpEQkViAF9zMXNSL07SkYTLm2H/iWPN6q7KRTYhDmyyjSFZ3GYi9
         f1G8tLugOn10UzHcr++N8qpqsRnVCmymGkkGX2kj7pdLrDamS68hffdFnlwPMo+M8S6d
         0REKlZ3xPz4hyO8iWtti9DZCM9Q65XsS5YXUFDQyPpR+L+khr/8i0UiQkyk1x87LMAHB
         cmEYYpTKTNhFroX7I1NQzh2zqTkTycUL2vui16p3koZJQW/RbTQr2iRqxCLAgGyQzfd1
         iJSg==
X-Forwarded-Encrypted: i=1; AJvYcCXY4anKaDGs4sEAjo6Pp93tl0fW9qjWYPLjaTw8d0qz1Xv83HUqrAoG/12oNrOd2TIMJEXHyg+TnKb5ni1o6u7ICsLXCxUm8XPcsN32
X-Gm-Message-State: AOJu0YyGuJd1hYhVbzxsi/Ok3DhtXzACdWzlTHd4TdU08JSZY1G87xhC
	S7p2WrFxyJdoDcWQFLelVearQoRc4DlyJKxbGPJNEIWwj8GzHV0rUnMN2VUNmoo=
X-Google-Smtp-Source: AGHT+IFYA1dhRvmL2GTj5Q6k/vk2zOUsQMMogmi/rc6o5NV9inVq5WoI7Vq75aDni69dzFSZ/DMrow==
X-Received: by 2002:a5d:438e:0:b0:354:c43d:d5a with SMTP id ffacd0b85a97d-35e0f26984cmr10765554f8f.24.1717517217961;
        Tue, 04 Jun 2024 09:06:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04da756sm11983392f8f.59.2024.06.04.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:06:57 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vincent Shih <vincent.sunplus@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rafal Milecki <rafal@milecki.pl>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Joy Chakraborty <joychakr@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 manugautam@google.com
In-Reply-To: <20240510082929.3792559-1-joychakr@google.com>
References: <20240510082929.3792559-1-joychakr@google.com>
Subject: Re: [PATCH v3 0/1] nvmem: Handle actual amount of data
 read/written by suppliers
Message-Id: <171751721565.70889.16944298203785853489.b4-ty@linaro.org>
Date: Tue, 04 Jun 2024 17:06:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 10 May 2024 08:29:28 +0000, Joy Chakraborty wrote:
> This Patch series stems from discussions in patchset,
> "[PATCH v2] nvmem: rmem: Fix return value of rmem_read()"
> (https://lore.kernel.org/all/20240206042408.224138-1-joychakr@google.com/).
> Where we come across the fact that currently the nvmem suppliers do not
> actually let the core know how much data has been actually read or written.
> Instead they are expected to return 0 for success and the core assumes that
> the amount of data written is equal to what the core has requested.
> 
> [...]

Applied, thanks!

[1/1] nvmem: Change return type of reg read/write to ssize_t
      commit: f5de138db5b76de7d96d4cf92f871ba893ba0119

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


