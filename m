Return-Path: <linux-kernel+bounces-520199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB658A3A6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD8516391A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0691E5212;
	Tue, 18 Feb 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7tRfZmX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21381E520D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905693; cv=none; b=dB3zyXdpj5aot9/iiBa4Oc5+1N0TyjKkDddxQvhmjEHqNMFdZ1vMhEdK8k4BfG6j+qdGm6mJb2K8cSngp/wp1Rck86fpj7LTiEFHpCYtbUWrdbNSQ7jlwUcX7q6MvWPz9pU1R2fmoqsNeQrF4fh9UDNQY1wiKhr6CakLf9hOj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905693; c=relaxed/simple;
	bh=qYAZTiqzP1po9iMBaj0lHNXjlSX1F1TWryWziMbjTVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ3aJTiltIg6e1wro4+JjUrfyS22g1H3neQJd2E9sibgTYJqYTYh830pEXjXj6T+ow54CNQ9EUavEXS42yY2mhLx6IbM9+MzkUKH3gEf8zNzU5xlhuXTYoc5XJOyzs04ZoynDcqB1tN4Yk2oLyedE/MA5d6z9APnwkEqRLo415s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7tRfZmX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso4021558a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739905690; x=1740510490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNsBxEX1Tk64WX5P1Q2cqgd6NAXQLvCCopiRfOs8H1Q=;
        b=g7tRfZmXQU2D748U1SumVD+ZYfFUS7ND4alUtIn0tttFxBQWv/V19rgYggvLEi59q2
         DLpUKTXOgLyqy7HQ8g3azS2xdRBjijJgp5euwZQqdq/uHvgZ4wLCMaV4y7z0aWoinny6
         6muwik33Js2WiPjA2wrRdgFy3GzqSkCVoLcVd3mZyQ1t2kLWE3dS2ALGrql/i2xVPxTS
         g328WK9r3Ejd6qzIiIF+KhwWUDr5ly6LEGgGxU0OSsfKMH1p1cOp8D8VwOn+rjwYSzzG
         mKayVRuxSGq0POnDrwft3mjIDpZmA/HBHR/0anM7a2Egdn98AmUQ75oWAutoIPqYTyud
         aLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905690; x=1740510490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNsBxEX1Tk64WX5P1Q2cqgd6NAXQLvCCopiRfOs8H1Q=;
        b=c7DaCQ4EupC388qxFMn2tsUL8of4hqBhAMohTRQEcxiLFPL9RNR0IHOphZ9Bdrza0q
         AGa+9ac7flVIPXkQwXeoSsIZcc96q5hD/llZ/6fArjmBzxiVxKV5yApiNlekhEzVF9L/
         XNBtH3xSkUy6jTxRySBs5CIasXwSFr43VQLNJ/qYY6O7uNKSAk2D8zvODXu5fkjwfmGD
         ocm35rgT2CzkvZlYfsIt6BlttpqB/4uaA7p7CMm3w+DGjrfPkyI4FLeIhhNCH0ImT0o/
         We6ifQFDPGO4BqziewhtfjDKTOjJWjRmRM8MrOBJdzWZibSlBso3cSRF9L1Xtrt4NgiS
         m3Og==
X-Forwarded-Encrypted: i=1; AJvYcCVHl2QniUWgr7dZbIaE1GNYqtcBukAGB55kU7bjeAz1//aTTYoHZY7jVqWIHmq8um7Qid/bqGMd6NMkIBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7UAht9AeHBKHQSWTjV1QoklVKJKvA0JHvRIinOKnQXico54w
	0jj7AF3B6S7/8hgn2jkwSUvatp0903UkSO8IaFrExJ+0vPkfx63f2PtUus1t4iU=
X-Gm-Gg: ASbGncsA5cjtXcXjOzfBY4k9pvqpVXYG1aaJWJUypLKINkUlkE9d4ungRfwZ3f2as2U
	7Jvz0ICaJZfPusGDSk2SyOcQpPsjVu3lI2BsUFS6v7HSjiMJIhYZl7FCa0eKrC7gbqAAmzhEjDW
	FU3qqi2zDrKnSe6s4xTX9FvGFaf4K9NFLC9lNtA9XGx3fKo2IfI+9mrkNtbTJH4PjX9fESh7xQh
	r5oyA7ka+/vgm1KEtgnGZHS0ADbLjKpmbjIPuPUZQEj6w02xMXOFAbr4/xAqQNr5UTu8rBkL4wh
	Hsc5S4YtHUgDY/Rjrdj1
X-Google-Smtp-Source: AGHT+IFlziriHnAKD1HuHccq2KQBzmgCVFxrmvHg/JF2Df2oa6sJkUNmECTIl18g14D0PF+iOjDlAQ==
X-Received: by 2002:a17:906:26d3:b0:abb:b1a4:b0fe with SMTP id a640c23a62f3a-abbb1a529b3mr486697566b.1.1739905690148;
        Tue, 18 Feb 2025 11:08:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbb0fb63ecsm244309466b.115.2025.02.18.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:08:09 -0800 (PST)
Date: Tue, 18 Feb 2025 22:08:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase issues across multiple
 files
Message-ID: <6259457a-3a44-4b02-bc83-19eb1fc05e49@stanley.mountain>
References: <20250218184343.20585-1-madhurkumar004@gmail.com>
 <20250218184343.20585-2-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218184343.20585-2-madhurkumar004@gmail.com>

On Wed, Feb 19, 2025 at 12:13:43AM +0530, Madhur Kumar wrote:
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

Quite a few issues...  Take your time.  There is no rush.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


