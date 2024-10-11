Return-Path: <linux-kernel+bounces-361730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900899AC50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0D528B135
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACED1D0427;
	Fri, 11 Oct 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtvLOl9i"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED61CEE86
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673189; cv=none; b=bD5FMnWeffs7sZSWtmgatWYAxxuGD07d4iqgr60lp+NeJKLDCYhSF+AxKxY3p6Pu79BprbA2/CZIhYC2Hxhgh9zCGqicYaxVuX8FTb7InipODxe+aGGcwHGblsp3lfyn4htO/QN1n7gD+mqehVt804imI91t4NkRTMzZC5KgX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673189; c=relaxed/simple;
	bh=DVB4dVhVZ/XAV1+ShuvPw4FP9kY0aGQnXBc6U6sbKJc=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=BIkwmUhUFYnN+R5Z2rZuUo8K9ywG5wglahcMiZfFwOCtLf28wU4DGJLrnvk7mFfy9y67bZ7qFpgfLp5EYAumswQswtnZn4CNbhyOovZex3HbcEfem+Ltq1w5i0HpQUrd8a4aj/S/A/MEmq3F3ZQzgxO57Vr5yHwYZj40QQ00BCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtvLOl9i; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99388e3009so318150466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673186; x=1729277986; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:cc:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrSoOBsX+fyaOaBJqOaUdYh1pjEXpggjg85T8AzPojk=;
        b=XtvLOl9icPt2Ej2bN2hxz2975rHsWhxmG9iaq5eTzOQLXr4E5YqqPR2OhyySaiaVtv
         T9jMLuvhkDJcNmGRYzEfBJvKtDjAoX3ypkMjqM8UIqvzrbc6anEBsI18w4z/243PWfgF
         +QG7GZryQgK/5Q/DPPHbmVwcdcYI4+FnaXQ076F+M7K1Yoir/VWZggbFVz/sQaC5mNts
         UyXoewC3YKJAadCNWydFeWUL6unVSOWHttqmcm9fz3KdT5TM+f2+NR1MSS+k1WMugif4
         HUJ8rKggmqBIjLtv43L8zTUqA0Gib3+jVETB1uOxCihR23Dr8eVxavtiglxnLuY9Y+Yp
         ZBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673186; x=1729277986;
        h=content-transfer-encoding:to:subject:from:cc:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MrSoOBsX+fyaOaBJqOaUdYh1pjEXpggjg85T8AzPojk=;
        b=Y7KLm34crpuDtdHghE/oE1tChUFS+uqo6UmrzC0vuFsfTg174jr0diNAk14xgVZWzI
         yFLkLE8VhKqj9tmTPGDME2ceDtvNyxzfrrZl9aYdrC47/AgzRIw15Ebz2HBiXq3WWWHJ
         jLKMDpHEfCbmr9Usxh4OetvP4aJEj4DYekzzYEqXPFCQcaJIx2qexZOpToWZ48lTmukx
         k9RYwx7Pgg0Wo8s4QYVkC+G/GYUrj7rrW788xvUsWxNM/G+yZF7amVSE+TNguNHTcZrF
         nAifTE/C83jqRhLkcNIatrxKuhhPsLjL72x4N4BJkjyNY4D9BYI+ga57VyFNOw7ATwYg
         B5dg==
X-Forwarded-Encrypted: i=1; AJvYcCX3sNQnT9l+c4pughBcYyKyQdMUmwZ7L6PZcn8O9oIWvDOejbNEzBD7Xr55AWHVIp+hxRSEFSGDMddFM8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaybSdCwbp2Sb6Er+OJKuAyQdrzMg9TWazqJJ21ArVjATjPcq
	mvWJ4GaTvayYQwsa5uy7GjoSve1lK+C88WUSYyFnxzCFLFP1yMryeAhFlQY+
X-Google-Smtp-Source: AGHT+IEBAKE0eElGdrA3pm59neuAr7gQh275QTJvmPc8Jwiq7IX1ASgkODASR88cqmv1tZDgfSBNsw==
X-Received: by 2002:a17:907:961e:b0:a99:89ea:3643 with SMTP id a640c23a62f3a-a99b9711d61mr317961866b.53.1728673185829;
        Fri, 11 Oct 2024 11:59:45 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec56eesm241064366b.31.2024.10.11.11.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 11:59:45 -0700 (PDT)
Message-ID: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>
Date: Fri, 11 Oct 2024 20:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Malcolm Priestley <tvboxspy@gmail.com>,
 Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Straube <straube.linux@gmail.com>,
 Sathish Kumar <skumark1902@gmail.com>,
 Florian Ziegler <florian.ziegler@posteo.de>,
 Pritthijit Nath <pritthijit.nath@icloud.com>, Arnd Bergmann <arnd@arndb.de>,
 tdavies@darkphysics.net, m.omerfarukbulut@gmail.com,
 =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: vt6656: Proposal to delete driver vt6656_stage
To: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Forest Bond contributed this driver in 2009.

The following points let me propose to delete the driver:
- This driver generates maintenance workload
- This driver has a maximum 54MBit/s as it supports only 802.11 b/g. 
Peak throughput is 3MBytes/s.
- ping times can be 17ms are often above 500ms and worst case 22 seconds.

I suggest deleting the driver as it no longer meets current expectations.

Former Maintainer Forest Bond <forest@alittletooquiet.net> is unreachable.

The staging subsystem needs to focus on drivers that support usable 
hardware that is available. Newbies can then get the hardware and play 
around which is fun.

Please consider that support will remain for years in the longterm kernels.

Thanks for any response about your thoughts.

No response will result in a patch for removal in 14 days.

Bye Philipp

