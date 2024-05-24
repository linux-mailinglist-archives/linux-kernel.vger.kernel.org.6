Return-Path: <linux-kernel+bounces-188861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBE8CE7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF611F22514
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC812DDB2;
	Fri, 24 May 2024 15:29:56 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3E12DDA4
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564596; cv=none; b=rhRdvYiUUCsqf33laXWjLVaAmRoaReE5te/91bhFriUP60AX1C8wJYX8a20QZdLzFuHHBi683rt5hd94fbP0LcxUujIwXiTxOIH2dNMwaeNqRt5Ghuzz6kEiiGfjiwqmwF2Vui+Dp+W5pbMl6mkVpLmpJjssP3ESNSDsvrgzHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564596; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vwr82kz+5Q70DExOUUuG9s+yftbrmwAuOOmjBB0kTkZBGSoqp4UiZsym1Iz588Chtv6CcEeDUsX1/qhTC3x4Pb4InANm8jWyLHHROnTs6Y/znsrsKxHtbXbI+ebWXz/bChTuc+2NFhikcgSeQecCHm/W6XtiarApTg5sZcc4q5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354f89a59b8so403981f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564593; x=1717169393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=io2ntrKI6k+8SeE+J3lx6/5ElZ5s1HwlUCO9v0KSWiymp+xf6joII3ySTKBQOxzH87
         BvVaWtZTpZUNTxjDRfke7VDhswps6VZRM9xYMe3VCjzcq1GacveXzqSJp7hCrZg95WQC
         pHYdwslgfoTvAvROXN2Q2I1aE/ElZqDtyd/9npjk4HMANm7UGZi03r6X7RXXKcRnA/Q8
         i+j54VJth5fEfUAReW8vjXVMSFjmBkPvnagAj9VA5dFbdwDXiHQSAKqXuyJH7zB/uoU1
         JO0juctINRullOQiWgD+sjA/pI6IEkmJAF0P/nA7KPl9lCP4T7c87F3OkaA6aw1HaonW
         UfnA==
X-Forwarded-Encrypted: i=1; AJvYcCUwjHUs9zQQGwCqSROjzYFwgM9BwoPqJ1oB8uAoJjFzrd5penq2/TZJbN+S+BLPlHVIOjzmljy0sGagozwcjo0m5Ba29NVGq0awM7zO
X-Gm-Message-State: AOJu0YzEyqjt3cszeB//UQOSfITZwJN/zlaGuoM5tB82+72455UF1xAW
	juQ8ayJKhLFQ6xBZ8G+MCzP3sJh7aeLpQEsvMpIqle+9Wg55lehK
X-Google-Smtp-Source: AGHT+IGydm3KFFkEOm5Dej35cysCFu2y3Rn5joLTpDVvHql4Yqq2H6FRVzp7ujzne9BypYIC9Ekc0g==
X-Received: by 2002:a5d:67cc:0:b0:355:3ec:c7e7 with SMTP id ffacd0b85a97d-35526c39f44mr1702503f8f.2.1716564592913;
        Fri, 24 May 2024 08:29:52 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3564afc3577sm1102707f8f.102.2024.05.24.08.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:29:52 -0700 (PDT)
Message-ID: <d492a0d3-5e3e-4f69-87e1-9d251ef604bf@grimberg.me>
Date: Fri, 24 May 2024 18:29:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
To: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
 c.gameti@samsung.com, gost.dev@samsung.com
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com>
 <20240523113149.29174-1-kundan.kumar@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

