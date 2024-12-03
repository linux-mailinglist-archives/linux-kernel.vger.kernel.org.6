Return-Path: <linux-kernel+bounces-430355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E049E2FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A4EB266F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA762EB;
	Tue,  3 Dec 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+GuzvKq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD011DD0F2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268652; cv=none; b=EvPt5jLAFcm/zuRlDL0L2ODlo/Tftl6+csIF9jaPAvEOB96HiSQDnksw/6ux/nIJZwLR4i70MfSJILDYlr8zhLDBSQBvjkv28JTvHF8uVEscLI70eqEiimqUNljtx84uweeHvcDZi88czoQl/8JyG7ZR89zBAzUNFEdxFk6RTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268652; c=relaxed/simple;
	bh=PDknFXdpGhwUK2oPlbIEPPI4qbuJekgaWv5QKIrdr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bM+Te8bBgxPZVkIgC21WK1RJ1H+osRRBt3DJcrNGUWPpq5/+iHlXVkxGzwVvL+ljurVWkfWWhy9b539bKqVh1envPNX40fahfCDSymT2qob39tZF/Ezz4i7jswFtMi9AEvPkKyGDNoGB1jpwucA9VhtOyf2It48JEjEqHIa/BpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+GuzvKq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733268649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAco2OnlW8aDB56vFSNzE6OdCv1iUGJFAjN9JJ7q2Z4=;
	b=U+GuzvKq78jUP/8R2c5yYbHRIDPWUeCa6nSjMKlFgxkFPGEBAACL/ABqbDlrEdD1wEZkPG
	qAnnqVIByNL0e3Za9JtS6DBgPRErCIL4SPCxALJP1FL8SRwuAgLICJvDov1HPXjwspJtqG
	fClpGZ4cBV54/yDCd7my/84w1vYvMQc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-LTN2Ky5wNWOPrQVriCvQmw-1; Tue, 03 Dec 2024 18:30:48 -0500
X-MC-Unique: LTN2Ky5wNWOPrQVriCvQmw-1
X-Mimecast-MFC-AGG-ID: LTN2Ky5wNWOPrQVriCvQmw
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8418358cca3so39331039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268648; x=1733873448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAco2OnlW8aDB56vFSNzE6OdCv1iUGJFAjN9JJ7q2Z4=;
        b=cnDDIMloY/TtU2fgj+fS2DQutYx68pTvzpVCK+zdmDwvNrtRLdlEMMmsvyZEE5hlZJ
         03wT2YtKQjN8yeTSLu2RhBm59wD78xLIHk0NdApA2uFMkq3GbwXY7XiJyf75xhAhCbAx
         tCSsBCzU9aF+z/6WTlOynUqw9T5mdsN0CXdSgnonz++CkaVk3v3c9pmSTJ5zFrPhem0U
         mUWv3YcmRDVa4y5Qf9FJMRfp8qph1WvoirRAAmXawVV0dhLH3HLRBYWB/d1e6UIbewpx
         RiKtkVRr8zk91Az0TKioIvJ8SnTa8XpngkV2c36pPqbkmBExwk05X7oD9SQFbkc/NiZu
         YEzw==
X-Forwarded-Encrypted: i=1; AJvYcCVaWuK6LQho0owAo3vHc7P36ZKY2GQ4gh5Ohk2gX32c91y4xmU7ato/mMC4a2ZGmoqkRgSIKCb9UPWKXvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyplHlWYgPN43TrT7uYL7p7x0SKK64MrpoG43nWCcWDAy0CwDqG
	a6hAlyFIwF9QrvrgPVdYJpAV1M7mmtzlfxe0VecjXKRft0rX6lJGfuH5ys/v7mVmNJDoBB74K9H
	ePgSl1TF1Mt8ekEFewBI7pWu5A5A2kLNT95RQGKo1LK11DFk3GKXLhgyhtkdTPQ==
X-Gm-Gg: ASbGncuJePs85HK6zjo94bwI4BQF4WV+PAZs8qoU9XyKLMrj7ylLAlsBjDPQ2Iutgkq
	k+ZJYF43UOZwcj+XvATjp85DwxjzDuyDVbfQlZMY1wQnvL6Fv7y7x2m/NjRPxP731uPuu7kbQAJ
	2s8bFl/BNA/NZYu30wzrxAqm3XBRChZ752VOy6QRugRqXVV0x5KTFes3bLOtNFU5ZWmqJyoXPHx
	cBW0fKtd6AScMsIxN4Pji0bQWMxlHPwonPVutvgZJy5MHvLtbnTWw==
X-Received: by 2002:a05:6e02:144c:b0:3a7:bfc6:99 with SMTP id e9e14a558f8ab-3a7f9aafd7cmr13695725ab.5.1733268648106;
        Tue, 03 Dec 2024 15:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+wpy2rKtQZFbUAdq3aq94BSEljgs8jDST4Q9+2gSut9sQitp+ZDXPOMOy+3t/TK/Xwp0r5g==
X-Received: by 2002:a05:6e02:144c:b0:3a7:bfc6:99 with SMTP id e9e14a558f8ab-3a7f9aafd7cmr13695605ab.5.1733268647775;
        Tue, 03 Dec 2024 15:30:47 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc5ff8bsm28460895ab.53.2024.12.03.15.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:30:47 -0800 (PST)
Date: Tue, 3 Dec 2024 16:30:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241203163045.3e068562.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
	<20241126154145.638dba46.alex.williamson@redhat.com>
	<CAHTA-uZp-bk5HeE7uhsR1frtj9dU+HrXxFZTAVeAwFhPen87wA@mail.gmail.com>
	<20241126170214.5717003f.alex.williamson@redhat.com>
	<CAHTA-uY3pyDLH9-hy1RjOqrRR+OU=Ko6hJ4xWmMTyoLwHhgTOQ@mail.gmail.com>
	<20241127102243.57cddb78.alex.williamson@redhat.com>
	<CAHTA-uaGZkQ6rEMcRq6JiZn8v9nZPn80NyucuSTEXuPfy+0ccw@mail.gmail.com>
	<20241203122023.21171712.alex.williamson@redhat.com>
	<CAHTA-uZWGmoLr0R4L608xzvBAxnr7zQPMDbX0U4MTfN3BAsfTQ@mail.gmail.com>
	<20241203150620.15431c5c.alex.williamson@redhat.com>
	<CAHTA-uZD5_TAZQkxdJRt48T=aPNAKg+x1tgpadv8aDbX5f14vA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 17:09:07 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:

> Thanks for the suggestions!
> 
> > The calling convention of __pci_read_base() is already changing if we're having the caller disable decoding  
> 
> The way I implemented that in my initial patch draft[0] still allows
> for __pci_read_base() to be called independently, as it was
> originally, since (as far as I understand) the encode disable/enable
> is just a mask - so I didn't need to remove the disable/enable inside
> __pci_read_base(), and instead just added an extra one in
> pci_read_bases(), turning the __pci_read_base() disable/enable into a
> no-op when called from pci_read_bases(). In any case...
> 
> > I think maybe another alternative that doesn't hold off the console would be to split the BAR sizing and resource processing into separate steps.  
> 
> This seems like a potentially better option, so I'll dig into that approach.
> 
> 
> Providing some additional info you requested last week, just for more context:
> 
> > Do you have similar logs from that [hotplug] operation  
> 
> Attached [1] is the guest boot output (boot was quick, since no GPUs
> were attached at boot time)

I think what's happening here is that decode is already disabled on the
hot-added device (vs enabled by the VM firmware on cold-plug), so in
practice it's similar to your nested disable solution.  Thanks,

Alex


