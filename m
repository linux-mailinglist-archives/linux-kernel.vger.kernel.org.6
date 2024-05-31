Return-Path: <linux-kernel+bounces-196239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342978D594C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2421F25908
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923007A15A;
	Fri, 31 May 2024 04:27:19 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682A78C80
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129639; cv=none; b=JlsvnU5x1FdVyGZpO+YQUWd7K/xZqEv1lwXkzYbf/YwcOo/2sG0WEl6acO+W/sdzev9uf9pU/tkBvLtjY/j6AdX6p5d+5etILvfyzs0l90ns2GLyX4HNvACFC2OcLG7wbRP0x7tLnBM+q30Vdy7d97jMZHqC/egFn6tapiLTWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129639; c=relaxed/simple;
	bh=HKMcOpiHI6pPvp3WTEDZeQ8ROXmtjUo0XoWydl3PoiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuNtVSOA96Af9SY/wDSWusCC84Rawi1ktHnFCWpJrkE8nbvEboaVJSlesLd24ZP9GkATGKIKQmhaZ/jT2Y9CM556nnr9T4jHvP9x05sqk5AK0rE1WWl8N4tNRsBQ9nCLhGGLsQIO2xd4jfYmzoO869uJGKnQFZMijHwfSX7vVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4212b102935so419165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 21:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717129636; x=1717734436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMhU6ONqx7VzpejGc29mu0haH8B25NLSo99kjECHleA=;
        b=bpdJ2yXbEJDZjBIpdUr7ltjMO7X+S7dUMiTrxP/9xkz2fMaBCV0T5oMU5OUSgqCn6P
         6I2Vc/QUFVDZfcU/MrqGU2rz90hAhUHnpd/hrReC2/9pqnA3M5HnXfanqlw3r5hE6+A2
         EmT9LlCBV3knpNZRVf4C0DjS02l4ao5JDXD448k31tmKdjz8FXGPY0Ikq3n20/pH3fxc
         6W1laHAYJlrFMAR31sKvKZabNvyIeN+2Wf12Ili6jQwhiMLmJ05KZkmSBWV0LDRYo9fk
         tnE8+uQJvcTOy0UiDb2NCb4pJ8PXZwA7s+xbDIuxwDDMjmGVmXribacOCfp1M/oZix4i
         5p4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNrcfqjTu0Ax0UHTqq4X61CPgP44QZkwxMfZnTkAgFD0CfPNv1gFQ6KohhsTkkafXM1rPK1MryWnSnZwqcPZmCYfr/Z0W1+Zxh6Hy5
X-Gm-Message-State: AOJu0YzNxBIdHgp302IYpAj4Gj1id3TJTshnUYiLlovynZ9u2G0pZGPO
	zLt0vwlAG2M/aXDyiYlnCkq1NGF7CpN76CdtIBBpCVTv96vmLE/zh5Kj3A==
X-Google-Smtp-Source: AGHT+IG6YzXnayr3//psDaQ5EjQJEh/NDUfKm5ouwEGMHvrVzW1s62TBKYxs9iwQB6AjvGO/Xrwqdg==
X-Received: by 2002:a05:600c:1d28:b0:41b:e83e:8bb with SMTP id 5b1f17b1804b1-4212e0c158dmr4509695e9.3.1717129635707;
        Thu, 30 May 2024 21:27:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c10fdsm885124f8f.17.2024.05.30.21.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 21:27:15 -0700 (PDT)
Message-ID: <7c1792f6-dacf-494c-a6a3-04b48596f903@grimberg.me>
Date: Fri, 31 May 2024 07:27:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
 <dfb9074c-d019-4a19-83eb-00d93da8dada@grimberg.me>
 <BYAPR04MB41514F3EA640750D6C68AF56BCF12@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB41514F3EA640750D6C68AF56BCF12@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I see, what is the mdts?
> MDTS=3, i.e. 32K
>
>> and what are the r2t lengths the controller is sending to the host?
> r2t lengths are 24 bytes or 28 bytes.
>

Umm, so your controller requests 24 or 28 bytes from the host at a time??
That's unlikely. by "r2t lengths" I meant r2t_length field in the r2t, 
which tells
the host how much to send in a h2cdata...

