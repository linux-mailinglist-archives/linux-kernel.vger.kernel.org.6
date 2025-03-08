Return-Path: <linux-kernel+bounces-552320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9525A57852
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6793B5BB2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D71624DC;
	Sat,  8 Mar 2025 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH/DllM7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD1DDAD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408725; cv=none; b=PTaZOPDOk4qSpoplQRtNs3yNiMtlJKFHieAgzz/TVD9cwp6hXA/9GR6KoD8RL2e/JBmhV19hoeEw/yV4DSMkB1OMJFRTjGZLr2RjHwS7OIw/xOroZ2sHP2rMdnd34TzWFVxdGuGKOZc12MJ1p2EyGY50chL5aBnVtKaKePWn1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408725; c=relaxed/simple;
	bh=oYD3dChGCgEhoDXXFBbs/qCCL/9kHoWCs5YB8iY1dkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F622scPBXaQk7WPq4rrZD0s9damSu81OpqPDdYhCTYXnj+dDa2NrkfMzoVfrZaoC9KVf0/qM685M8A1M+2R6j1jN5Ru+r/slHEBpwvgHEW3F5VdJeiHtS/Fs5ye+xbSEhxIXBZBkOKTh55FJBvtiQ8g87oLGZrNsxY7TSm5f8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH/DllM7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741408722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq6OWn+ZGytTT3SEMWGNSgqkOxWtHCEr5x6fELBfolY=;
	b=QH/DllM7e9DX59E+2xY3XYLR7k2c6ueMSlY7iyayrMMX/LF2ZccqbYdH0iB6T0vx7bl4t2
	uzPkt5gv71kHywLJEYodTN5m+xDx8MKE+JoltcLh9iGUMvOqo0GACSvLw50cj8wk684tMQ
	1AqqNW6Rf8MYmw3kpXIlNgvR1179h1c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-xnZc9gbHMKqK2q-R7RDkuQ-1; Fri, 07 Mar 2025 23:38:40 -0500
X-MC-Unique: xnZc9gbHMKqK2q-R7RDkuQ-1
X-Mimecast-MFC-AGG-ID: xnZc9gbHMKqK2q-R7RDkuQ_1741408720
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8ec18a29aso30460296d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 20:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741408720; x=1742013520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq6OWn+ZGytTT3SEMWGNSgqkOxWtHCEr5x6fELBfolY=;
        b=TVDj0Gakooqn6hv3iDBaBO6+5Ml/SR0qoIvxqFcAuVlnfMlSmMkm3R45mWiNqfcIYH
         mB/iIHQzXDjsfkgg969bRMmwlxAVFEXwAqm8oyDDLlP0bFE8n5xhYi8/pKuwSHwWXZ1G
         rs9jdFzkG3uds2VtF7n4EFeOx8/niLpz13wt4f/D4iBW7MeJu+BuRUpRD2JUSYtClAFG
         I3lApqiXzdp/43LvcmiYEFCiqlx4S+YA9uKold6pvWFOojGeZw142lyTA+eiKENDd5jA
         cAFKd8AM1RVSvn1tcWfiITpjAjksR0dl1tvWeqkam6HgNFyHIKGfEwkMrNVxJk60z73D
         fFqQ==
X-Gm-Message-State: AOJu0Yz4hnBFNFr4uyfgXUGdqxutb0xvdDhhZx4yYhEtiHZBn8nq42DV
	fSUSABpCUWtLqTUsIsDY6GcNJSk9tjTgklHjXnP381BWFvZ/OvAZFYCKrvQsQl47bGZYvWVtf2m
	hGW6QlcdQbovWaNLub83cxUIrIOOmOo8RpKwtTOzwO7B+fKKcTivt8zJyu5xFucAHgUF3fA==
X-Gm-Gg: ASbGncuwM+nR1CxQme8N//8iXC8HvxM08ZOtgxqlLyZxmWIxqLUQtKoOmxUpyZ167ZU
	jX1PZPrJW8okzu3zlUIa5sqBDh/ec4EVnmY4MMPy7qaMB/+qhyaJiK1WGlFqW2J/hejG3Re2yXL
	guFuUWevP6cITAcPrZL7hMEMkj8S1m82qVCnTVs6Cd1B8pyAINzC/HqrWSVfE0icCUlWGd5JUYf
	AuowJelYRzUNY7zWo7Tj8/PbpsAJBHPlSjIyXdTPWSS29G/cbOmCfrLOKn9CflPpaUPUrCJAJot
	Q1fjp93U/tAIpO6hrDcocdMFqGbK2ApYcur3QBCabEqn0vZenSdSVHF3q6xU5iXtq3KPrk+yaVZ
	iD0dnXwhq3OsQIHN+m5Q8
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e9004f8506mr90389856d6.0.1741408720229;
        Fri, 07 Mar 2025 20:38:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9YmlcyOq5Sq8DJrGB19ZavzadnpX7VLeIbhGmlarP+HC6zAUjLg/COlwKT2yfvezh/i9wkA==
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e9004f8506mr90389746d6.0.1741408719976;
        Fri, 07 Mar 2025 20:38:39 -0800 (PST)
Received: from ?IPV6:2603:9001:3d00:5353::14c1? (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a4e6asm27686366d6.55.2025.03.07.20.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 20:38:38 -0800 (PST)
Message-ID: <9b1b2a91-75f3-4ea0-9f55-5cb80ccb9e9f@redhat.com>
Date: Fri, 7 Mar 2025 23:38:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvmem: core: add nvmem_cell_size()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250228180326.256058-1-jberring@redhat.com>
 <20250228180326.256058-2-jberring@redhat.com>
 <1167c489-92cb-440e-a2c0-4f47190de5ac@linaro.org>
Content-Language: en-US
From: Jennifer Berringer <jberring@redhat.com>
In-Reply-To: <1167c489-92cb-440e-a2c0-4f47190de5ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 3/7/25 12:42, Srinivas Kandagatla wrote:
> Hi Jennifer,
> 
> There is a similar patch on the list, could you take a look and see if that is usable in power reset driver.
> 
> https://lore.kernel.org/lkml/20250306093900.2199442-3-o.rempel@pengutronix.de/T/#m97bbb1870d7140661894a4e806a695e563588524
> 
> --srini

Yes, the nvmem_cell_get_size() function defined in that patch would make my own nvmem_cell_size() function in this patch redundant. I can update my reboot mode driver change to depend on that patch instead of introducing my own function for the same purpose.


