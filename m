Return-Path: <linux-kernel+bounces-519568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C0AA39E20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9333166F97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA123770D;
	Tue, 18 Feb 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSaQdgfW"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4272269AFF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887177; cv=none; b=Uv7+pQ8gCw1e+f//iZvLaGORqsGUElSeYidy9PrmDOoj9DIOmFRNbuvXqU6RYbgioOrDeQWUmT7fRREEvbzyWx7ws07Zxa2+Tfz5pAqCUBRL5U+v+Nh1ywhYkao/MrbQoTw1pNCF9lrYnndH/nXi+sM5K9gYDVa6WxjGD0IOSoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887177; c=relaxed/simple;
	bh=Mg4S3drr5m4d6JFCyffBIJyOXmTqKGKsbJqLYgmzjKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq02yX9OLUmJLNQSW6VUlsgtt4zt5BubX50XXuqfymSHYq94wWVSrZJiI9pHMEr7knN7AeN11IfTczfH6zBzbPvacqy6oyLX3kbIpOyet4vhEaKWaYlEhkJDls2jc6/wyyPmWejqnAWIChzoWfSmIyfU/xqEXx3q/LZgK3yCSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSaQdgfW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fb68f495d9so20340217b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887175; x=1740491975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBKOvjT4q4+r0xsz7Cxmcb+Agb6bdL44dfyQfoHeLQg=;
        b=jSaQdgfWYAIp5LFteC/yvp5tkGgbED4xJ0vX9nsb5SwyafBXhaU90jwdLIVASdNi5C
         exZdhlYCJjzciNIz+AjBY5E044rDuR2Y9vNRtE6ms+HB+AeOZdAhNaqTP9nN7bvE4Fbt
         sRWsAOh7UsCOuKq2nZ3Psomz9mVSbVPzAt5GDSXoE87PdkKR4HnHnGVFMuImYgi1kRoF
         ww/MiqtnppZgUKmq7dHmuJ049OPhJWPHLML+a+V7sKVFf5B40Bron/R8IUb9BnZqu8CA
         8jJw6+wlPVdyRHSKGijEItITIheSmNKEJ10meyoBWgNXu1YckmBh6FHkxrsVoU0ovasD
         za2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887175; x=1740491975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBKOvjT4q4+r0xsz7Cxmcb+Agb6bdL44dfyQfoHeLQg=;
        b=Syx/G1PgFalluQ0irX75HsnXX2dt9yXhO0Vm7t4AG+9FpnqprkRLGLItyIfEofyNNx
         HCjnbOFCJH5cVL3ycWTNag54TuCVW30UuIp8/a22OtWsCuw+XSG/ZDHBl7+QAWeamW0t
         wHLePsWOh5yeEmTTZRbr4yQyhTolsiIXfuDTFvgY0ewYAtdvu+IbZawqvqlZiIhDy6kX
         Vl94S1HB0w7UJ+o+i+lrm3f9e5Ei27SlX1jg5Bi+BKrPkHjXV+DKN+CNB21b4G1bkdjv
         BpgATsLWU0c1tbQDO6f31NXcx5xzerxc3Jaf7Fqp8vVY/QyXeIBEg7XZVE4uf1eFet2L
         Gsqg==
X-Forwarded-Encrypted: i=1; AJvYcCWzPuaOFgWst85xcq8NHSVGZzSeODMIsYTWmuNscHm3e1oADjxjgDF0CBnM6qqxHnXZSyRcP9IxWa3LhDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMqogfRu21ucE/WK9dzhIjDrjaWeBkZcU/LyN6y0AYfVJ0UfU
	Z6ywqUGfj7cglCrXIXduOEE1gMprtP7zyUk/psaC4xmQm9gprs3I
X-Gm-Gg: ASbGncs2qlT2+o+1wfg9P83F8ruC/Y4G9kKLBZmy2Hg792iVZQaJTKzUmpCflu4jopT
	JzIqsZyAN8bJMaxoewKoXDECcHfixXyhpndkPvXfXvOL5sIKKZ1Sn/jhl/PGlcARWsPReig6Wgu
	vJ6uk5QS+iSm94HrWF/aWX0zfY56T6gowDBBOOvVXtANOZmYHTXL5bjPJKFKdo2n77CotSlkpon
	5aA3A4IBZtiYBcAvg1Tiyp+SUjL2MLte3HCDwJjsVi/D1cXGdtqeb7kV4ow+7y0FCMBQ/QSOvSG
	Gx5FREz+i9E3lEMevA8BafRJOP9ecEa8EbaFnFa01A==
X-Google-Smtp-Source: AGHT+IEtw9NTViCsSAfD+Y7y5H/yTDPI26ZQ9FfUOYH8m/a5smC8kabGnU1/gB9NTb6xN2UMJfJuUQ==
X-Received: by 2002:a05:690c:7085:b0:6fb:46dc:d9c4 with SMTP id 00721157ae682-6fb58292d61mr107457297b3.12.1739887174864;
        Tue, 18 Feb 2025 05:59:34 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb36083ae2sm26122107b3.44.2025.02.18.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:34 -0800 (PST)
Message-ID: <9fbca62b-36d3-c2e6-8ac9-28e51af80f7a@gmail.com>
Date: Tue, 18 Feb 2025 08:59:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
 <20250218084217.GA11129@lst.de>
From: Christopher Lentocha <christopherericlentocha@gmail.com>
In-Reply-To: <20250218084217.GA11129@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I just sent you another patch you with these minor changes mentioned, 
thanks!

- Christopher Lentocha <christopherericlentocha@gmail.com>

On 2/18/25 3:42 AM, Christoph Hellwig wrote:
> The subject line should rwad something like:
> 
> nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
> 
> and the commit log should be wrapped to 73 characters.
> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> and we can probably just fix that up when applying the patch.
> 

