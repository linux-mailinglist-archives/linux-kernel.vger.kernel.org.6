Return-Path: <linux-kernel+bounces-568342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D211A69437
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BAC188D2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7A1DD0EF;
	Wed, 19 Mar 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YHG3sR5z"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB61C3BE0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399655; cv=none; b=mCJZQad7Lrxkujs8TRZ+EWPQuOvk9OoFUGg0fHTXe+jin7BZPve8v+gfmzVWEwZCIJSi5L/Xwz90Ddod6S7S9t6IhADCUrpYFwspDRmPpKPuiFNC92MXTm6O1QwkvBFlTXH28xPNxPVMCzWMHelGMsUHlncJ8n9nd27MX/S/b+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399655; c=relaxed/simple;
	bh=uJhYmWt4kz9HYzPP7LyvzGESskOTkR8JU8W7IjmWUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYBMHJb4bXPQo7UJSlMCGbq8v5aJqAbYFrY7JI//lnZr4ADQbUJkgDm8GaOhVxQ7MtNLXqt5ijn8HsWxtUe3sxWBowJRPgtiDKpdmM+RAJpY2ADdgx/u4L6nCs7/ujLZTi5Pqmx/HOQDFkeFCRIdnEQtOKSBMN2AiE5YSOslA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YHG3sR5z; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7273b0d4409so1857277a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742399651; x=1743004451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJAw2RLlJLWsVz4/sB5t0+VZUbRaLZIqPwHY07oAJCY=;
        b=YHG3sR5z6ZVeEgy0+JLw+ODoAQblDpICmmrf9J5XxJ/ofjf10LzK8qOvSHPn7EXey0
         zBQ3XdRca0ZfiZBGsXmiwBgutVZ91hQVnHy8WOgKaeqAN5NX/DlkY4BnTRX1D7OszDbb
         sgCDeqATYB22EsQGuld9YU5MT6yzH1Qj00fABXNnuZjUv24SSJK1tJNnZDyJp/jlepry
         KlCwNEBBfewT2l6BphW9Ws4ep4euWPZlYS0BOlFP1xsgtASlbyuCXwCECiP6YFsPHhJD
         AYO+7FuHb/TAgs5TAYdsiMNnRzqU6lEMiVWy8/7dnRcYE+7oecIrjXZvNq09YI9F+bYI
         nz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399651; x=1743004451;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJAw2RLlJLWsVz4/sB5t0+VZUbRaLZIqPwHY07oAJCY=;
        b=kCNwsCd/+YgA49sm9uUWTOwUs5VojdNK6k5OmsoAwl+OzaBW+egKr9kOhE53olAFm8
         QSjYbTd4BJyHf4NavBgMtoNEwLXwgj3ux3URk8ldbfErtR5k0h9407Q5yBOheD4hIOPC
         9nLBSbIEzZ+EMBdsAEYXV9Wuk+I5eq2nGq1eZtVmvbmBkIrAagAXI03eQ1mzmHxQ7su/
         5DAUf57GTX4Zv8EBYQXY2ZjZIpI2trhQAqPdQrmC1l47rE7bZzbTxg8JwpBnzFNhz6/L
         yCGqyqLGistwyt4S12FihHIJX98SJhZhGBFHZLgY4iMq8pYoOpqLuX1Jsc0TmXg3cKVR
         lTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoVzrxbfVyeJ4fdsLHderrB+099z2u3OABEVyr7WawF0JGWE30/l4+yZtO8blcKqGXWQFrvd6El1isaiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLl/0lsb/tKvGiL5YI4YACtdcQjlhKVu4a30P/fr2rW3J1PXF
	0IJyBPcrK269fdicLGD0qkx18dEQnVKki3P7niulFVG6xLCwkKPE1qGjnYzqKZ2G5XDrVaksof8
	sryU=
X-Gm-Gg: ASbGnctez6yIiSYQkV5/sVW6AZG8TmJMrEJrjzW1xbqjwlKjapPmVMoQR3M4HUOaTHp
	R9yUJFkMEebHSY6VRp4LSuEIxxPt3ZJIPe0rjJJga2QLSyHq+UteG8rZRDBpfHsBevPWVCtOoT8
	uxCBQ8Y/7F8Q14Ao4zUCgnikM/UfOSquCt0VlmYy4waco/CuqWAGDZ6FxrEZ/i7E3y2A7/GEffl
	+54ZmhmkJiG13JBtbXR+vUZ1++sfSDVYZPYDQgj94VSfVLKNMODfYKmuhovIDeGQfcVbuhW9TwO
	IEzgCZNT0NzBu0OxQpi44ypSFna8fpRnI6enzz6Ok/osbesZ61Hb6pmCKp3TdpZ94j0aVZUossh
	z9wtuJ2cylTgafXXr
X-Google-Smtp-Source: AGHT+IGjcbCOR5dU8JA6fAFU3lfPqdzLtlKPsAilRhsTgjF8Vo/DLdEK5WYA3/7mdPtOIyUm8/BgQA==
X-Received: by 2002:a05:6808:d52:b0:3fa:25c8:a037 with SMTP id 5614622812f47-3fead5f73aamr2105453b6e.29.1742399651365;
        Wed, 19 Mar 2025 08:54:11 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b9casm2624226b6e.2.2025.03.19.08.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 08:54:10 -0700 (PDT)
Message-ID: <993d3226-f733-4093-8a7b-cc51007700c9@baylibre.com>
Date: Wed, 19 Mar 2025 10:54:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: dac: ad3552r-hs: add debugfs reg access
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/25 10:45 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add debugfs register access.
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


