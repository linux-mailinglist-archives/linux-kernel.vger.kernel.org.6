Return-Path: <linux-kernel+bounces-334853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46297DD69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9CC1C209A6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7821714C4;
	Sat, 21 Sep 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsdLZldx"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185D149E03
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726927814; cv=none; b=oezeNo9A6Bf6YPtESTB9hOP1i15uxCv/DZCsMwraIPhQeGporOXGZdkCv5kwSGIunvghbkNVDOBdyad+dO/UOo55ate7pAGMlwxfdzqDE/7WV/fyqbP6+oAmM5EwkCl3/4+QksYIlxVfQhvsyFzSJtHzOXeS5mwUg16IK8VkYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726927814; c=relaxed/simple;
	bh=hnDiBGQpDXACiUc5CzaBwn1G+dXC9IgeleoQOKeOVq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kc3qJLB+3cTewntFWaeiIJSErhQ+z2ndtKDrRis9rADj+UzziLalvIi3Vwhz9LM+Vyz4deUNfNPT/NxeCsBjZIAV/0Zrwr47IIidmT0hsJOGZZ0KbmO+dTAwIotoSbBU5vQhHv74XspQ+VVL0x5usDQLPgEFjat30gjgm0fl8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsdLZldx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c465578555so2096587a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726927811; x=1727532611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Va2GHCSVvbFzqlLy4/Z3bbc+8WuiNPLRTpZiEC7ifO0=;
        b=DsdLZldxgwI8MwvY1JinjdT4gW4taKG9Db8J2ZgVrA17H4OYXQfY+qHlbmSYL4loTj
         YzTySSI1DYqFqsddcISs1NX5nL8Ke6IPFPILzgFYPLJQB3Lnt5n6K25+dwcQVIL4VQgE
         +CFZSLln6AwlZJP1cfD5dkpcJCGBQRk+9jtS1dmeN2ahzlZXJoc79YUfFA209vd9Jsc1
         ZIuKhOJqsiVRJvOKgIGuCqJt5DCHgcSfMrXuvYiKca5aG+s9/Vkk9gXpa4rUxFXEzO8K
         7Jpz6zxfYI7r0PUSzQ7zJ4XKLqTA5rOa9o+Xlyk5lW1mUVUQAggJjArPbaso7KwdfGgW
         DoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726927811; x=1727532611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Va2GHCSVvbFzqlLy4/Z3bbc+8WuiNPLRTpZiEC7ifO0=;
        b=gmXYlRVEtbtmvyxtyRZJgoz4LX9JhXMctPM+H3ZZfPV1saiSBgTIQ1nAVJok99xN+J
         rH7aFzJrwas5k3XAhhZzTFwKcA9KtRR0Mkfsc14zD5X36rte2xrE+1ouEbOJQqKVJdC2
         DAG55gmazZ41519tN9at3igB3e5FYwfgpcdNOQo390E1WAOEGE3iu4Cjw1xN0ptnSGSV
         8C/q95mqVHfpfszVB4q9Wlhz9JYxw275zoHsMN5WNVPFC0rerCzG5AhLMeSmtEEMtPF4
         Attl+hqixgwbb2LlCux580bCK5n+YdwJHxomFMVADBN0ZtSF+u+rG6ktXXqMTpcCayGa
         UQxg==
X-Forwarded-Encrypted: i=1; AJvYcCUTpiCJ4UgUYRdwyzplHpwQf5964qYlEBokVI+keTFCovAbbNSej6YAbgUITIGJIsDI/wvGtxIYrI5lafY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnp0MglB0rpyP4iGGI9zIKv2lU8pOMlNyUuhwqKIR4w0x9MP8
	uV4nc7XJ7DpSSUWxOR2cgUD3t48VjoFBzIKXlxmUauGOuG9KDstWG5YHpw==
X-Google-Smtp-Source: AGHT+IFb1M9LxkWZ2/EmDrefgELhOU6BduH8I8jNkpu0X+c9J4EoZTvBwXbskS6PuxHA5esCHJvoJQ==
X-Received: by 2002:a05:6402:1f8a:b0:5be:d7d8:49ad with SMTP id 4fb4d7f45d1cf-5c464dea3fcmr4858174a12.22.1726927810333;
        Sat, 21 Sep 2024 07:10:10 -0700 (PDT)
Received: from [192.168.2.100] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a0csm8328281a12.79.2024.09.21.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 07:10:10 -0700 (PDT)
Message-ID: <e7bfce0c-74a4-4c0a-9930-a3fe9d5ea5fb@gmail.com>
Date: Sat, 21 Sep 2024 16:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] staging: vt6655: Rename variable iTDUsed
To: Xingquan Liu <b1n@b1n.io>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240920162025.31465-1-b1n@b1n.io>
 <20240920162025.31465-2-b1n@b1n.io>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240920162025.31465-2-b1n@b1n.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 18:20, Xingquan Liu wrote:
> Rename variable iTDUsed to i_td_used to fix checkpatch warning
> Avoid CamelCase.


Hi Xingquan,

please do not take the first letter when it is "hungarian notation". On 
a first look it seems that the p is for pointer, i is for integer, a is 
for array.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

