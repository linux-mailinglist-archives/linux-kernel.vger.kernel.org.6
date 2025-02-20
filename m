Return-Path: <linux-kernel+bounces-523445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7AA3D6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAA13A331A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0A1F12E7;
	Thu, 20 Feb 2025 10:36:54 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD51D6199
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047813; cv=none; b=Xlp+1vPrNdP+KDKu/jVxUsQjKxVGBipu66Yvb6bbjNHisN7fHJZY0bgNejgqB2GN+Baf1Bgew6Gcs/qN4a53TNU2Vfn0ZkTHaWqYKX39b9y31hF9i73CnE/jKZIvXdHomJVOdmmSYiDQYEIxettWFfr8z8Od6MCJY50JzxW6OY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047813; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9R3K0G7dY20ZwgNHz7Pl8yTlu9HJ3iqKG9jtwoecaPNzIU3zwekPArVcomJAwd1D1viV1FDMOqKnPe0APTy9WA+U33QIayk4hLAwsMwqSnFmBHOxaZk69eRta1YUiA5IGFC56Gq3c+lf6+Ayg5BLI93LDdBmydknveEkC/L+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so233605f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047810; x=1740652610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qa51TWI7WhFH/kfqeJ+JPFW+Ag0CWjUYGuKhCfNGYCX56L4Azw6+AJ/cbatBmRdL/I
         7m437ENrsK9AUew23l87vCwAUiP7aN1Etgf15Nul97bNkm7cNFd/7Gm9EPvGxrJSb5Kj
         1OYUzkzqe9oHcDuwSCeLjEQmCRiz3hILCib+mYGZmXCuMLpysT2019+thvMqaIEf4sTa
         nDWdPmls7S4dUbTarr+nxra1qBeY5utRHgnoeAnmOoY9bSwsCLAusV8AwXya4BSUqoub
         ndGfn+ek7S4krlHu1UAyXC/8l6yfGNdwXOof+2Zkqu18X0kn/olxQ0KI3heltsypai+a
         LWIw==
X-Forwarded-Encrypted: i=1; AJvYcCXkTN3R/QqHGg5ZQCfW6IpT8KFbdJ52v+p+msQFm93C4gzMmTiGbZ2XZ191bIhBNkN9Htac3zkrZosK5KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPk6KPiVOSHUCc0C4nCxtL2wCXJ56len2RzrhsXrF58Zp8eE4K
	PW60HVrHv2NpQIN77ZMYihGrtXOwbzZ+ZGlrbo7ZwkXhoi4EFCgWnZhlOg==
X-Gm-Gg: ASbGnctZJva9/1ojyQM+ZXTNOFcp0+aWAigepgCJw8BkhB/4CLiwgFcVWkCZetYIWtt
	J1ishGklD71pmDaru6PoaJMkEZ5rehiGaKSNF/1FkWBBdRm2YqccjHSyvtcZJVwuqDZnyo4rjx2
	kvJZmFFyFwzb8LZxHNAksQ3n9KCGr2Px0XHRNhABN4T2pJiaAkLpyIL6dVExNfRCtBipOxME88S
	XigkjgCSeBbS87qAN99dzW48wD5kquqbFvCRUhj/AwY4MskFv26Ekp3frjccec3R+ennK04SZ4g
	dKmv5XAyuQR0ZjHhv3t3uVlajyRq/5grZ4qO6eBTuAGcMi6KHHU=
X-Google-Smtp-Source: AGHT+IH+WsYkeZiU0mPcqvV8ektXE+C84F/4T4JseUt8pjcNjNbQ00MxZEwmZ04LscaLvifAlaWJBg==
X-Received: by 2002:a05:6000:1948:b0:38f:218c:f672 with SMTP id ffacd0b85a97d-38f65145d52mr1367990f8f.41.1740047810058;
        Thu, 20 Feb 2025 02:36:50 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm19908811f8f.1.2025.02.20.02.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:36:49 -0800 (PST)
Message-ID: <4881fc9f-4d99-4a5d-9182-c003c855b972@grimberg.me>
Date: Thu, 20 Feb 2025 12:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-fc: rely on state transitions to handle
 connectivity loss
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-2-7a05d557d5cc@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250214-nvme-fc-fixes-v1-2-7a05d557d5cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

