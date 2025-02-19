Return-Path: <linux-kernel+bounces-521513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C1A3BE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D49167866
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E79D1DF974;
	Wed, 19 Feb 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0F1ro7W"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A51C6FE3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968730; cv=none; b=J54H0IO1A+8ECxrnC1PVMfj2O0E3tiFrDe6exnqlCtwjN0rvxv7mayofxlkrSlgc9B2D6QhpMH2vFz/qwczuVjEVUzvb38xOoYsjqbh9V8eSsMreQ/tOCtD8ZxkfbKiYKjEAJfX9VnivxP+OIgLYiWyuLbXiAM1Bro/qOV6DM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968730; c=relaxed/simple;
	bh=ZZIZuTeaAoFO/P3zdlI6Eu5y/BY1YCPLBFDq51YFA1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=barILJFOrMcEJBEzD4hJuzUjEgm6/E2TSnkJUeaCQdO2kapDxU69/7jjXQ9N1BW25OgEEDDCl8o7vlpO5TMJeX/74QjXP53iipkluwjlwPTt4umJcVi5XKGzMfFoaqtbqWBs14jLG7+hTuyyZaZTg8tjYNnHmRxRsR/v2U31SPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0F1ro7W; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4398e3dfc66so24836415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739968727; x=1740573527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wj3JrNUhg35mjfieRS2TI+7IeiK1zMMxQs4U9cM29c=;
        b=G0F1ro7WuMopAkx4nWm1fesaru8jeYKdmx6wsceqcpeJwpR7lwgiz0he68aqgHLQOB
         SP4WF5cRhb7URYm5egE+Nj6/++cCvBd+F3AhO6r093quWp39YRrJTK/xEMrmx5A9dqsP
         0Ul5XpnANKbkUBYA3o7CwGs/T9ZTDHYjhrUaWEI+hyQtAnW17k8Fe7eebbfixVu7DN2m
         QB6G9JGA+jlaRmX8zDRuGyymXkmE/6l+DaH/aNyhT++HRcmkap2vesB0vuqsObh/kCvh
         yQ+jHS+affElNj40jGsqPY+qJWcdULyp0ULk9lVANgdajlPdVu4C6orHxkSUA80znUgp
         tD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968727; x=1740573527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wj3JrNUhg35mjfieRS2TI+7IeiK1zMMxQs4U9cM29c=;
        b=Etb3SUKD35+2/bsjrbxsbAF03iQ2TIY9XybAs18QyQZaVb9AeWAH14+GGlhts2crC7
         4KCv3GgDvALjvN/Yt5F3ncqwXqzaz5DQutmd25XZGfeg0WTN1QqfILoec8cJ7ckulKDe
         vAENZOkS/fm390YyV5eBWxctxxyJrQ101hBXIXbfCtMhK7TlXSyeXLPBlnjp8NT9/WwG
         ApwzrrKkY4o5MWXGevbz5m7UllcBy1MXVaZvuSRvitbCUYDCTsHv3tNeUAcwK4SOeWPC
         EwNc4ZB63pY62QGWY59k1VqMYq2I2Yo0FZiJFguLT61YAse9HVXIZaJ9KsYPoXn4l9p6
         BWxQ==
X-Gm-Message-State: AOJu0YyvwapMf7MBO6J+lnSFS1Iimgd4fcnxmGjaYZ10ry4Y3T8KZaiP
	Cbjy94zFM1MLbfQGh0FRwuii208ZeiSbvnyZYgLOlUpia+LLoOh8Uux9FoquFIc=
X-Gm-Gg: ASbGncvhqriRaTV90ADXd62TPapHtVsavbMmUpHyA+LDZlmvs0cLURtu2RLhP1MydGC
	CJK79TNkjxQQhCisbF6VZkV2cHrr1IbenuIli2UnYx6AOEopBGu5suIrkefg84bnvaqVbn6f9eR
	60+IxvOHzJDk2G+72Qi+8V8IfE20IvvzwxrHqeg9EUx9iKQDJoAsyL+UV2zuyP8mcvZDuY9P8fT
	vXTxVjS5J7oucsstv0I2X042dcjAdKmjk7AZ47RasJMLFTsVCBpjrTGu1eUsumlAOYVI6NdywZm
	1ti3+8VkT6ByCNMjdLgP4uJLjk+ppoApdj/BIwRKPhUL7WY/YO70B3w=
X-Google-Smtp-Source: AGHT+IEHJKEFS1/VXZbvg78fmSTXn4dztJg0x/bM2Gn3fvw76lknofTT3eKLDhhDFYuIqpL40BKnFQ==
X-Received: by 2002:a05:600c:5124:b0:439:6ab6:5d45 with SMTP id 5b1f17b1804b1-43999ddae20mr30956125e9.28.1739968726833;
        Wed, 19 Feb 2025 04:38:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258b43d4sm17488976f8f.4.2025.02.19.04.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:38:46 -0800 (PST)
Message-ID: <c65a86a5-fc65-4144-b780-ed9e8a59f1ab@linaro.org>
Date: Wed, 19 Feb 2025 13:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] clocksource: mips-gic-timer: Enable counter when
 CPUs start
To: Aleksandar Rikalo <arikalo@gmail.com>, linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Serge Semin <fancer.lancer@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>
References: <20250129123250.711910-1-arikalo@gmail.com>
 <20250129123250.711910-2-arikalo@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250129123250.711910-2-arikalo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/01/2025 13:32, Aleksandar Rikalo wrote:
> From: Paul Burton <paulburton@kernel.org>
> 
> In multi-cluster MIPS I6500 systems there is a GIC in each cluster,
> each with its own counter. When a cluster powers up the counter will
> be stopped, with the COUNTSTOP bit set in the GIC_CONFIG register.
> 
> In single cluster systems, it has been fine to clear COUNTSTOP once
> in gic_clocksource_of_init() to start the counter. In multi-cluster
> systems, this will only have started the counter in the boot cluster,
> and any CPUs in other clusters will find their counter stopped which
> will break the GIC clock_event_device.
> 
> Resolve this by having CPUs clear the COUNTSTOP bit when they come
> online, using the existing gic_starting_cpu() CPU hotplug callback. This
> will allow CPUs in secondary clusters to ensure that the cluster's GIC
> counter is running as expected.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

