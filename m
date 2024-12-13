Return-Path: <linux-kernel+bounces-444932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8499F0ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20141188EC98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A311E47A8;
	Fri, 13 Dec 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N4Qscovk"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180D1E411C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099027; cv=none; b=nrOa4XUgwd1ezRh6v1JfyLo1GnX6yR4BaIth7vTD+3CiccsI0i0L0FGuq+qG4Jk6kDTRMhA4q8pz77BVpUcz+TFUZtbOmw6NLch4DNQPF5uo1buTXovoo4q+WQJZesqUn/R6RvyABl7S4j8iGKSekZCzgmhAVfzfw3xWqgIlQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099027; c=relaxed/simple;
	bh=M/3qsNo6fnQrkBRqAhbDHQs4FxtZxNHiE4Cr5op23ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN1ZIT4j2wKbFPtm+kMyl0rupHV9Sq6c6q2AC8PXHOzmwDM8ffceQK67fdwFErESuz8s9GFk6jNywz2AV8WKGBn0d+os8/f0vJ5crL8sozbTh2dzmJXAyt1LVvphYVOsM7+p1Q978mlIeOMWNTpj0ck2MXUsgFlU1sth+oVCUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N4Qscovk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so5833605ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734099025; x=1734703825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wfl6jDipoM+iXy/XrzX3Ue4HwTxVya1qYRo+7SB8Mw=;
        b=N4QscovkF69MpySo214j3gY5XirRIix66+k73bSmMOovW7+mcHAT2Hw5dgix+xd1sO
         nJBj0xu151qpOQc0HthqPgaT0FQK7HsHT2+YSqtdE0lXsbeIaDZzmB4wWAFhWEBvK+MK
         5t4sKPsgkCd0I6vlaGT1s04eHHc0fpI2b6VAVXDw5W+HQgiwu8eXn4fQkRVrJ6t9z4ci
         kAwdgYtL8rds6uhdcMCkLBRBJYc6z87idLyzE9KKs99hJ0Bf2DJQt25moXvAeoU2Aik8
         wO+RIvT97UmWe9EKp/7GUpixN41RYQcXyAW8x85JTn25FYGg8mWWXENLjbJKCJ2/Byi9
         facg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099025; x=1734703825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wfl6jDipoM+iXy/XrzX3Ue4HwTxVya1qYRo+7SB8Mw=;
        b=UNkAzBTyydQOA0eL0uUGI6lW1Thj6cuZ9/R8XMJp/F/VEEncH8OJ+YAxE+6hmwWk7v
         zAeOiJ+8V+3IxbU9GufPvYqEChpEVX2EK8lmBb4vg1hi4w6GNl6/hA02c7vvGEiUl/BE
         hCYyJX80Nw2mUdq8g5rG5Se+cy35rkoibKugNhPln9uWq8OBzwGdNWhlTlGspL2Gxi5Y
         2GVcaP6EKhFRpfPGZTOcStSxmWZQSntTg089VLcApSaK7VhdgyGgzvJTvHZ4COdI05cs
         /TQO+TE3+vgExnqrjg/I8azwGMFiPp0WlEMehLzMCpHTGMaoF8EdROLPjnhCqI0gQ1ph
         aauw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1Ex6LolHg0r/Rrldod9Cfg1pqoImlRcKUmJALO9TcdW1UgDjJHV9zvDYhMoRcsrQCder1swLfHKQMc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6yzjtJJ1hxG9sjn0chnu+tHxgVxBGYN12M14YQ2uKz+e2PMj
	f34b1rfiMANQ9XT8k75wmkEZbDVd7QOmCfHUJjkVmRNUhxkn49xCcN3fN7KO2Rw=
X-Gm-Gg: ASbGncuKsY5dh/fROlfFP78UOQxTsofQR5tEou2T0lX3LM+5HuDpX8qRe/9UFW+Zp83
	U0t7Ao5CJIgrMBVwUKKpxkyb6vUc+Xees+Soym6/+3sHHWwKbDFcsBlEgKPl7IH4HWAHaMqHmD4
	RS+0C5LoCAVmX3gNStoL84fzcWh2WJjZmGKXqX2VgSmyD0SNP9EgM1nXZfozuvyFhfTWKDWyoxY
	Pa42qmQAV5ujvrGGr/fs3JvGoIWavDS4xSwUx2PUz0UC/EOMmyx
X-Google-Smtp-Source: AGHT+IEQIVHSuIOvO9V5srGtcT1Jf7+noQvdCF4m56AcXwN8E0OAEd9cRIgZmBkxkdMcO2zHt7+yeA==
X-Received: by 2002:a05:6e02:248c:b0:3a7:8d8e:e730 with SMTP id e9e14a558f8ab-3aff2dd5e5fmr29780005ab.22.1734099024775;
        Fri, 13 Dec 2024 06:10:24 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2d144096asm1881611173.80.2024.12.13.06.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 06:10:24 -0800 (PST)
Message-ID: <13797474-3ad4-4864-bd49-2fc1f6e47ccb@kernel.dk>
Date: Fri, 13 Dec 2024 07:10:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deadlock in __wake_up_common_lock
To: chase xd <sl1589472800@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDRFJ9jtXHqkX-PTKeT=GxSwdMC42zEsAKR34psuG9tUMQ@mail.gmail.com>
 <1a779207-4fa8-4b8e-95d7-e0568791e6ac@kernel.dk>
 <CADZouDQEe6gZgobLOAR+oy1u+Xjc4js=KW164n0ha7Yv+gma=g@mail.gmail.com>
 <f1f0be9c-b66c-4444-a63b-6bae05219944@kernel.dk>
 <CADZouDS5xH8wC9k6SpgZ=dP8A99MvppEt70Eh1o+vpA-k8ZXTw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADZouDS5xH8wC9k6SpgZ=dP8A99MvppEt70Eh1o+vpA-k8ZXTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 2:36 AM, chase xd wrote:
> Yeah sorry it was my mistake, the patch works perfectly!

OK good, was starting to think I was losing my mind! The patch has
been queued up for the next 6.1-stable.

-- 
Jens Axboe


