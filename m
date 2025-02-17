Return-Path: <linux-kernel+bounces-517086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2697A37BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC116B2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EA18DB1C;
	Mon, 17 Feb 2025 07:11:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D514C70
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776298; cv=none; b=jqp1I0I+6jseThON2460luwbJd5TbJhavWNtJMgXMdl3d3qaAsJD7MuE6+qwYYi9nVjlt9t54yepTu3LRbVPnJfRSgt7OaSFxDK1fNhfNjrzGcVBhEOQ6WqIwhjnuTL9tNSdhXqD4ldgRRxu7/B+SV2It/ha+ib7lWYbIFj3i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776298; c=relaxed/simple;
	bh=HfFlznV0nBxoLPm5hCaDqxRmAugufTREXGTkETPmjNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/1l0SC8KduSqD8/J29uHD+Rx/wZdnZJHjYjEHP5UR/2hMvpop0mYFXYX4HDR0FxQenHm+yXw5v0JRDq5KmH7Ezu+83019OjwdX2fBRy3g2UjHi+IMzDMUiflxTXos3Lc79ieMV0ZG7Fo6dlOBsac6Lmrfm+uOH/stn79KyU0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso25237235e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776295; x=1740381095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfFlznV0nBxoLPm5hCaDqxRmAugufTREXGTkETPmjNQ=;
        b=VkzZ1kFGLS8Th2Dfe/8pZ7hQiM9DSCQShGvh/H3VrXX6xAXSOl5ukAPYK0SoT/EwCa
         Xd6qmhfjU6LYVBu4a0sYtO8gsiqMX/dd0yJhEVve4oWUzwRstXVjqy6WjpmGSrK8FiNI
         GDlvZkx1JC6DXi74bu+n96hkI+5xEu3EfRnJ0dXWb35/a5BIWyOMmHYe8tIUsnOgbt5D
         zu6szEFQa+1rMR0X6GA0vZv2Iy7ZHqjGuCgapcTz63LOhdfs1QbhBxayxxnzUxEhLlKz
         ZWNAgDTFstZ6SuYJmD2UDGX9NH2kr+0FgxCIJyjCieHmHxwa39POfl2MZYrUR7U0myP/
         iIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuqdGl5yzCE76sfoc1rt+h84PPkEmRabx2Wm44oo9LPU+hPFaQ6NmcPuZbbsbaCcMarHQ76abjfye3Ac8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfCQBlLrwor5n5LEjexzXRbj2byHxm4ZkmFac1NKsAcSigqiZ
	h4bf93Illggm6hEaO73KDFsPNDvLamf/VUYMaPRPHaXCziB4ecPu
X-Gm-Gg: ASbGncuJqAJ/pLJvT0fxepkPYahRZDX+ZGiB1hRjACQjU9FdJZzX50rd+3wnF5Jlfds
	l4blbHb2J4VYV9LR+xa9XKDnujLYBLA+6V1B4Fdbzio71jK/TqCJnPV67bH8I1FyPktq5OQR2yl
	L8ywKIm836VKxgu3yQ7YkAk2EVRN9d5ibOXwMYNot7xdLC58nqcWMTil+M6y2AQmQR3tIMM41BW
	qlk7x5EWGF3Nth5FGqeVyoO6GoQmpK2O6mMmmMOrGw6akptLSSfyPBDEqgFvcbEXi5Xs3XskEdK
	xy6idkmZI4SMV7qWopktHkFiDNLGwPSrxk8QdAtC7WxYLql8pR6NlTRUzQ==
X-Google-Smtp-Source: AGHT+IGBf7m9jJ8orGHtq7A3pyZr+hSkuDb8hp74BO/+yVf2IY+GcYDHhiDbWgtrJSrqMucrs83p3A==
X-Received: by 2002:a5d:5f4e:0:b0:38d:ce70:8bc8 with SMTP id ffacd0b85a97d-38f33f119d1mr6992192f8f.9.1739776294470;
        Sun, 16 Feb 2025 23:11:34 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dd5acsm11580225f8f.35.2025.02.16.23.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:11:34 -0800 (PST)
Message-ID: <dda59c66-2868-45fe-b943-2c7cf6d99893@grimberg.me>
Date: Mon, 17 Feb 2025 09:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
 <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
 <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
 <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
 <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de>
 <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
 <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 10/02/2025 19:24, Caleb Sander wrote:
> Gentle ping on this patch. Sagi reviewed it, and I don't hear any
> additional comments from Hannes.

Caleb, lets resend it with review tags from me and Hannes.

