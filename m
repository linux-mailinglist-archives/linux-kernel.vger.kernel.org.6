Return-Path: <linux-kernel+bounces-313063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8D969FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE80B24283
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0E1CA68F;
	Tue,  3 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKWPTccz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B01CA6A1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372175; cv=none; b=Hqw9iCjiaA7APjgjt35n4GMp3j+yMHpQKDO4XRouF9ZLCgPtVDEcp1cjJQsHnybQsVrK+JFA0i0f2aOh1H+cQ9aPjXONHE02USImWJblHuMMOUJXyVccU4zRCRvQYGqtg60lZRIlzWlg7Vw7ru1JhEJNGNXyCNKGRczuEtMelxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372175; c=relaxed/simple;
	bh=KbVX5/WJLt/Z0+uhwnKhCH5C1tCBFTeakpeppFQXWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7qYINr+sgc24A4j84rKxnK+OpRbjVBfyutY4tequzHYvj45WA4nb9JU44vD+fZzX+mqF0zcOKYZnL1lJMb6jzrpY0wKesPBOEIEjOXPhjPEpqGHGQsR8NsHGApsmhmKxWMmlUzXd4gdOtyJzoz5eGdTczzO3iMJkQeXS54mYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKWPTccz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
	b=gKWPTcczu2r3hjiarzVzbCGLDY1k1YwvcHi4/pLg5XfIlrBvAxEkXdiPY/6NIDOReDBLHb
	gPiMZ0JEEgd1dY8SRiWAykM+veBH7UNj6oNW/RysB/oaf5wSO2EwJ5dsjG3N01iv6m/BKO
	y2fOmNCLxzVw33+a9ITbqdEhiOQ6LfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-V3NVZmVpP1OsRaOqy88yPg-1; Tue, 03 Sep 2024 10:02:51 -0400
X-MC-Unique: V3NVZmVpP1OsRaOqy88yPg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c294d841so2466712f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372166; x=1725976966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
        b=sWPNfEFjW9joQ6+2Grkg9ojNh5O7S9XpN9lFgc3zLsfBdRXrbKgakIVVpNikudtHXz
         SEMbAxTxt/i7wR1zK5HlVNOuKLD4uFds1jek7N3Z318Yw3IKTe6uVfag20Cprcl0Cy0r
         cDqa6GezPLmh99jJRN3BzU5ApzEviRak3969zMjgquCgkHeylAXZfErgC0sf5K5CajbX
         9hJgaQnwiRJjHCUYcb1Moi5A0sO9i1YDBBSmkZyG2rYVy0vlQZun5M1wF498Zvxto+N6
         L8D6kG9SUHU9BxfR0nUuvMC8hqJSbSIPuavF5sPz1Rx3GmYfrcnOpyifI3M09uD5a/Hv
         gnzw==
X-Forwarded-Encrypted: i=1; AJvYcCXYgIIhR6Clzhzwc01S/stQLQT1j1FYhkZrnUQWuhfbc7q50iLm3sfmFn+jpx7eFHwq0taXcvk1EOpBk48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzK64V7sBCVQT3bpMqbBgr/3q+IjG9xmDH3WyflUqAi+Slx3Ao
	4iR1KACanEOyqEvY1APIgKlrrM44y4GqeoqtqogNwXkt3hwS41HGs59dXcrs2M0CF3F4/X1s4/6
	isNkCtI9CY/Fjgs5VvX/KdvGb5pV9M7rbjIt/ekgQEPQawpqVsEUKuKkTtwdL/w==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013552f8f.24.1725372164312;
        Tue, 03 Sep 2024 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+gCA4emCQ8lN+v2r+4PD0Xf7gtP5260Hobybyq26ysa18Yk2eN574I3dEkpcvY9bhrHY7Q==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013434f8f.24.1725372163170;
        Tue, 03 Sep 2024 07:02:43 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14372770f8f.50.2024.09.03.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:02:42 -0700 (PDT)
Message-ID: <c5658b79-f0bc-4b34-b113-825f40a57677@redhat.com>
Date: Tue, 3 Sep 2024 16:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240902062342.10446-2-pstanner@redhat.com>
 <20240902062342.10446-7-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240902062342.10446-7-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:23, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
> 
> Replace the deprecated PCI functions with pcim_iomap_region().
> 
> Remove the unnecessary call to pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


