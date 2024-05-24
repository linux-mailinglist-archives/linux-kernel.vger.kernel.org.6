Return-Path: <linux-kernel+bounces-188918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E708B8CE87A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EA1F23317
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744912E1EE;
	Fri, 24 May 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pq3BJCG8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99F12C485
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566915; cv=none; b=AW/LLQv1qYPYfvEVa49nql9pqsCSCaz5mLV/REvWOTi0ukCkaeeGUqusBBCBQQCW32jeq4KhikLoFm3AWGstRPCArenDxayNdpzF999ije+jf8PZMBag/wF+GJM7GeJMbs3VhE6VC+lY2cP0z+BguyoFRsX7IychzTYhpPfkqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566915; c=relaxed/simple;
	bh=exq6Vtd1oSOfzg1kMHw3YZ1MwxxjP2vFYDjQCzib8oE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=gBMU7O2rh93f1VKUmtWryXmOHLZpMpR+7KDRyUZDK9cqEAToRdAdXq4mWQXJg/b9XDTv8cHc8+bpehlD7Uge2VtC/rC01tigdAkHJsBWX3sp92JQUqvrn1JrOA90s0qtj0SoHY/rJPON/TE72u3YmlFD2vfId7fCwtUqrtcLeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pq3BJCG8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716566912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9EwsuqSUYRo+pt3iaFFkxaae/M20Vya0rjHfH1b6HdE=;
	b=Pq3BJCG8/a9JM9s/HBV4jtsQyY/TF1pp0zL/MpN8DHgIuNoaEP0sGKMr6EgUpZQ1CRH1Ou
	aklHJM7Uhl2hQrxbuieJXS/RaRk3TrxC9/hOzxtqhZpFq/T3ry1pKWoU62iNPAzKX+tt4Q
	tfTKE5MRvWoMdjIlCdF9wAbdrJ2ae2o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-74bSxkcPN8iqgQEOafz94g-1; Fri, 24 May 2024 12:08:31 -0400
X-MC-Unique: 74bSxkcPN8iqgQEOafz94g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-66348aafadcso2202863a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566909; x=1717171709;
        h=content-transfer-encoding:cc:organization:subject:from
         :content-language:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EwsuqSUYRo+pt3iaFFkxaae/M20Vya0rjHfH1b6HdE=;
        b=nos5mzNwaoavnPGH2OyAP4wPA9zV9d4ml8RKKXiflRgTdBm4LtF6lTNZEbdv85JGol
         pL21AfqCchUVqlJ2Rv5LwWo+pTgVNmqn7qEYNiSl7843iAbUbMGNB2x5cmNBfSAC4KcD
         ju1acx/JK2Y6lNwKuFaR0sAFsdXA/jh241zKEarVtslrru5mMun4dtME1voszRNxnBra
         vRTn1ykFE/Dbh90GA0z/RCTc67GgWst5eENULuoYITcnl/jTOtfmy9+3LBeudWHqjdk9
         2InqtEoxfmYpiwfO9QPbCN0qFeqLjZpFYrWfJWsXw1FZpl/bN4ohKU4+om64pTOmjgOO
         1/+g==
X-Gm-Message-State: AOJu0YyYmmebA3E7XTFAMP/p79CNhKguu8k33zRugXA61jIETtTDVjOB
	71FoCp9jiV5+dopWv/joWK/kXj8nmoPsf3zkREA8sGmw3cFQZxE/1QCXbwRa7XFmHsPAmq0qxV+
	fk6H2qiiF/vGz+7XEmjeoR6AG+QjwtuRo9uTYGVDKfGK6yGGhnM+vU7/r/mRn9t3KDj/BD5eOTk
	4HFIUbOEnzUy7ET1duPs5AtwwC9VSfrzPiAd8YcfWYBKoR
X-Received: by 2002:a17:902:da8c:b0:1f4:64ba:af96 with SMTP id d9443c01a7336-1f464bab257mr843375ad.9.1716566909201;
        Fri, 24 May 2024 09:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVAzB2NbvKOHgVznREzaRv64nuyc5oToZKRz+E7t+S5zlxeXZPJuO5VrhKYB5HbvXUxtmZcQ==
X-Received: by 2002:a17:902:da8c:b0:1f4:64ba:af96 with SMTP id d9443c01a7336-1f464bab257mr842885ad.9.1716566908618;
        Fri, 24 May 2024 09:08:28 -0700 (PDT)
Received: from ?IPV6:2001:569:7cd6:cc00:5079:5849:feac:f62? ([2001:569:7cd6:cc00:5079:5849:feac:f62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967bcasm15639335ad.176.2024.05.24.09.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 09:08:27 -0700 (PDT)
Message-ID: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
Date: Fri, 24 May 2024 09:08:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
Content-Language: en-CA
From: Adam Williamson <awilliam@redhat.com>
Subject: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
Organization: Red Hat
Cc: jforbes@redhat.com, rstrode@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, folks. Please CC me on replies, I'm not subscribed to the list. The 
downstream bug report for this is 
https://bugzilla.redhat.com/show_bug.cgi?id=2274770 .

I maintain Fedora's openQA instance - https://openqa.fedoraproject.org/ 
(openQA is an automated testing system which runs jobs on qemu VMs, 
inputting keyboard and mouse events via VNC, and monitoring results via 
screenshots and the serial console).

We have several tests that involve doing an install of Fedora with root 
storage encrypted and then booting it. Some of these install enough 
packages for us to hit the 'graphical' mode of plymouth (the bootsplash 
manager thingy), so we see a graphical passphrase prompt like 
https://openqa.fedoraproject.org/tests/2642868#step/_graphical_wait_login/3 
; some are minimal installs, so we see a text prompt like 
https://openqa.fedoraproject.org/tests/2642845#step/disk_guided_encrypted_postinstall/1 
.

Recently I switched up our configuration so most of these tests run on 
UEFI VMs (previously they mostly ran on BIOS VMs). When I did that, the 
tests that hit the graphical prompt started failing frequently on Fedora 
Rawhide. The tests that hit the text prompt do not seem to be affected.

At first I figured this was caused by a plymouth change, but some 
testing indicates it's actually related to kernel version: it seems to 
have been introduced in kernel 6.9. Fedora 40 uses kernel 6.8, so tests 
on F40 are not usually affected by this, but I engineered some runs of 
an affected test on an F40 install with kernel 6.9, and they hit the bug.

So to summarize, we hit the bug when all the following conditions are met:

* Running on UEFI qemu-kvm VM
* Graphical passphrase prompt encountered on boot
* Running kernel 6.9

When it sees the passphrase prompt, the test system types the correct 
password. When the bug happens, this input seems to simply be ignored - 
plymouth does not echo dots back to the screen representing the typed 
characters, and on hitting enter the system does not attempt to proceed 
with decryption. (Unfortunately this also means we don't get any logs 
from the failure, as the test system needs a booted system to be able to 
upload any logs).

Looking at results from the last month and a half, the bug happens on 
about 30% of the tests run.

I have reproduced this manually in a similar VM, but did not yet manage 
to reproduce it on hardware (which is unfortunate, as it'd make it 
somewhat easier to attempt some kind of bisect).

The earliest build I can say for sure the bug happened with is 
kernel-6.9.0-0.rc0.20240322git8e938e398669.14.fc41 .
-- 
Adam Williamson (he/him/his)
Fedora QA
Fedora Chat: @adamwill:fedora.im | Mastodon: @adamw@fosstodon.org
https://www.happyassassin.net


