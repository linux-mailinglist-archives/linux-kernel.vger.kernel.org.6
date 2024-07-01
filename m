Return-Path: <linux-kernel+bounces-236732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAC91E671
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10318B26C99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3616EB5B;
	Mon,  1 Jul 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMxmw1RZ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11C16DED9;
	Mon,  1 Jul 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854351; cv=none; b=F8BbT0iNun/ebhJoEDHRI4+e5sEgwduSe99sisoK5gIIgj4dLfkF4o0xsUfzaCydyKuM2nhceoZksAY1DfXpbJCduSHGSEc38UJreNOxjZ+qxbLcvhl89JgFoq9Ge3AID+3676WcvD9cXwClKhbobratKiua/mrxm5UWvch+OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854351; c=relaxed/simple;
	bh=7+9MUOvfw4XZTvRfd3+f44vVGIr6ay3eDJ/zN/lTsdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzSiV0T9Asr1E4AScGhYb29Cz+PK2+7nHB0sn6kohzlClH4ZjtlPLZsRVIddmhMhsYUxtfnquSY1Y43bOV9UxEoU45Hl7WX+pMqYghik5BONFKzRLttjqW0sKxdKHsZXVigL/1/UxDseUuiKlxR5rEvTulYoILujEqQcFwtF/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMxmw1RZ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9cc66c649so2011302b6e.1;
        Mon, 01 Jul 2024 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854349; x=1720459149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4cq/FUbNNF1yTpWqtDhgp46JMnbjh5yCmoguwHlVmY=;
        b=nMxmw1RZyueCOx4BXgijUn/dhHjIG5Jm0eMPQP6uJ7tlrx8SVDpARxzvpuvNEgaMDv
         2ndHKx1N/aJk/7dKXwnzkfByr7I1fNtAF2wf83zDmhj34Lz841scR+qPmK0FtWbuzMzw
         oCY7qCbnMyyMEBU2EoU7537nLdqiZwhtHQ/QNHyOpfqMFKtJ5DJDkKJ97uPf0ALpoACW
         k4PnfeONSqFGQF0z4hHsFaPNpyUe+9NCC/xibWT/EV9WBDFnARiKwGrCu/ZGb37JCgL0
         B6cEEqwYXv+muhVPZ+mKxL1z6u5PivIwGXZKV56K6QjKAYcgpdtv0LON5CA+FCDz6Ka7
         20dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854349; x=1720459149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4cq/FUbNNF1yTpWqtDhgp46JMnbjh5yCmoguwHlVmY=;
        b=D8XQeQCWqLC36XNqLHJXpMCsMQXSMMLanOZsnxHPBu2/EhzhGXmEJm/MjksGoLZ3cp
         c69LCe4viELt4kTV3YRjSS4LNkqR2MyQJqYWs+j/sNeFbMvETbbOseOtmKjFrH3Kj5p7
         nqQz3J8qqDiKVp45aA0HkO9PkSFHrE2Ka2AvBwO4ZEZfXZUvLvwT7tgfdMdpBpzkNoBc
         kb7x3jJk8MozuBPQkcZo189vzOtiipPT81yUPDyxRyPXmYX9mSnQP7+r8c6ZFlcm4cRN
         kWp7jrNVwEDQrPLlewzFs4l44AULdRHGZxzX/ARY0XkBhrb9rw73JzFKqAuBLZpnyN7P
         TPwA==
X-Forwarded-Encrypted: i=1; AJvYcCXlQrX9LfdHQDXPED7Jxy6g5YB1Bi5+xvO0D6XvHD8fgloHhGdWpgnf9BRlUqbH+KpPpA0i2KJFe+8q8VO9wigwcuGSEbVeQBGU2rX96sKycXDmGcKYNHULljAtVQCYKFxTFDg9TmbIwEbSo8v3qn4qFRokijonTGi3NFqkntXkpA==
X-Gm-Message-State: AOJu0YyzYUUZf7daoC0Y8K3BtJNXCtbEyhl7ru+jV3aPkTVjV6PxyW/a
	WEiLLQsKTw7uUHCsjD89w9nkhobffCOiL2tHskRmm2UowIBvEOCM
X-Google-Smtp-Source: AGHT+IGvLQeOFUMePYB+i5/7C0S7KMjlkKdy5fFOY6Qjjl4+0U+9y1OFytUq0T0IkJPqbzwB2Hmcww==
X-Received: by 2002:a05:6808:1884:b0:3d6:31ad:841c with SMTP id 5614622812f47-3d6b50c0aa7mr9821275b6e.47.1719854349011;
        Mon, 01 Jul 2024 10:19:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf9d0sm6802977b3a.115.2024.07.01.10.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:19:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 07:19:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	kamalesh.babulal@oracle.com, haitao.huang@linux.intel.com,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/misc: Introduce misc.peak
Message-ID: <ZoLlCl1-PMr5DKIG@slm.duckdns.org>
References: <20240701125259.2611466-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701125259.2611466-1-xiujianfeng@huawei.com>

On Mon, Jul 01, 2024 at 12:52:59PM +0000, Xiu Jianfeng wrote:
> +		if (new_usage > READ_ONCE(res->watermark))
> +			WRITE_ONCE(res->watermark, new_usage);

It'd be better to do cmpxchg loop on update. That doesn't make it noticeably
more expensive and the peak tracking would actually be accurate.

Thanks.

-- 
tejun

