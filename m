Return-Path: <linux-kernel+bounces-258150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7D93846A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D962816E7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924C14F9FF;
	Sun, 21 Jul 2024 11:09:59 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462DEEA9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560199; cv=none; b=d479hH04ybtD4+8++YXsD9aTeDIzxVlSdPFpQYbCe/exKTJlG06G6R2AmthsNJmXhXN+T4AKB07xBkK79EiEgsr7lK2mAcpY62a4tM7Qs1+3YPtQlor0fLoRRwMwnBPPfkOIP3TjCyU+Rae0mxNDyBMrhA3m/UDn8f2MkZxJ++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560199; c=relaxed/simple;
	bh=0zeIXAPfb1dWI/+j4zvmpRn5UCITaw9wrJcwFr/s3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTl/N0YyHk0UYzmGzD5GmZfVSPudRE5YsjwOO9Mm1o+vRoPE2tX0pU7V5jV8mVsvhV7n0mbnqtv53aQE/6DWPjGBHVeBxa5iqv0aoSe6FjFC7tf2ZGmle1bblNDris1vsVqHUcNFL74o1CSrm9t02Lo93YD3YJAl4zjzq4PjIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427b9fca517so2991165e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560196; x=1722164996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/IynrjMgMbi55MV2GhVD76WbBTEeRvWVxKv58rh/4Y=;
        b=VhNFWq5rqLDBX9jh+CxQgGexaKHjKXfI0c7tRTA+ZRA2skbZVHGdD+yicdQKiaXXaS
         mAB8bacRNgiBdfFE/ks9C7/oOiRFknscrP7+rM3UT2G3l+Hm6TZhT5SpCIPB8et3lCOj
         ygrsyCVyOBXqH/UXhdNYFAnsbRJrwJa3wM3/VRISyC1PpT7NwqD9FH3iKJVotXQza0Ks
         1ubvDGtUBMzD1gya3rk3lMT1/ttmkXOHdYPRCGWSmV/g5/g6tXFKBhZ6XjE88dElu4TO
         Q52Luwprk59qYyjtAWun9NDoHR6reXFeQD77eGAFEnTIlSzvVUGEZ0AzadeexV/Pa+Z8
         Wdng==
X-Forwarded-Encrypted: i=1; AJvYcCW63AxZ2FReB9DZUcJUFy8pEkIYOazTNIVPH7MNuKglGJxVY8XKDM857GpyQnV8L0dilN12jVijWlgV0HjZE94aR87r2qEt3XEKNixx
X-Gm-Message-State: AOJu0Yx03XNNKPjK4+xqTJ2bUoudTzAvIn9bH+9T7Lhl9vHacgT/0wnB
	j07f+Vfa+N5gbjYZBGyMlSrE30mOig34MKzKfuKZxJzvgEh+aEVc
X-Google-Smtp-Source: AGHT+IHxpSxN1f7MBxHKgrWT29UskOLAEGxo9QMIj/ZdXghG6KUFDzGdqt3HnwElwAg5so5XJ9AjuA==
X-Received: by 2002:a05:6000:188a:b0:368:4c5:b69 with SMTP id ffacd0b85a97d-369b69d09b4mr1407015f8f.10.1721560195538;
        Sun, 21 Jul 2024 04:09:55 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684773sm5741262f8f.7.2024.07.21.04.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:09:55 -0700 (PDT)
Message-ID: <8aa4d7e4-4685-4fb2-b6a6-c88bcc7a7740@grimberg.me>
Date: Sun, 21 Jul 2024 14:09:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
To: Christoph Hellwig <hch@lst.de>, Ping Gan <jacky_gam_2001@163.com>
Cc: hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240719053116.GA21474@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719053116.GA21474@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 19/07/2024 8:31, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
>> When running nvmf on SMP platform, current nvme target's RDMA and
>> TCP use bounded workqueue to handle IO, but when there is other high
>> workload on the system(eg: kubernetes), the competition between the
>> bounded kworker and other workload is very radical. To decrease the
>> resource race of OS among them, this patchset will enable unbounded
>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>> get some performance improvement. And this patchset bases on previous
>> discussion from below session.
> So why aren't we using unbound workqueues by default?  Who makea the
> policy decision and how does anyone know which one to chose?
>

The use-case presented is a case where the cpu resources are shared
between nvmet and other workloads running on the system. The ask is to
prevent nvmet to run io threads from specific cpu cores, and vice-versa, to
minimize interference.

The decision is made by the administrator that decides which resources are
dedicated to nvmet vs. other workloads (which are containers in this case).

Changing to unbound workqueues universally needs to prove that it is better
in the general case, outside of this specific use-case. Meaning that 
latency is
not affected by having unbound kthreads accessing the nvme device, the 
rdma qp
and/or the tcp socket.

