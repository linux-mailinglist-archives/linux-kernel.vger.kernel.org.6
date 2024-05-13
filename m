Return-Path: <linux-kernel+bounces-178006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D170E8C475C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB461F2382F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFEE4500D;
	Mon, 13 May 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leDbqTIh"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477B41C69
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627130; cv=none; b=AFSk+YCaEarhCzLK/7cRP7ufusc5RSFf5Yl6zPPf7ol47T+1qWfiWzyhyJOXT2BT+tdhlVwmyVPcZV2NjrRIeRvi8bg/QbTswO7pCh1fV+sC0+BwD5nXKn5z3VhQvvkMOU1TmZqqzTr/UZ/rkb7htHFO8nod/WXAJypdjvBq7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627130; c=relaxed/simple;
	bh=Qd9pTpgcaJj4wSWyYN5ZiytgBQrXj2hjTeEqFmjinzU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Guqa0+I1JniYxylmFiNNOZm+1HXIL95ZLYbCNMVUDiRcZYKxYGpAMkWRZ7Bv1OovrXySOjIuyL50YihKzmeVPDeQExBYeBYDmqhaUoRn7z1J1wZPS30NQgOCKNg3DggwEZzs2HhX5XPbflzyPapwWE28cDYC4XeCwIk/xiY6vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leDbqTIh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f447260f9dso3769745b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715627129; x=1716231929; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OWJvskzIIbw45+/i+3bkIRVAKtXhs9CdDBeK5iKrA=;
        b=leDbqTIhOSXwhI37Myib8ghYotU+Fa/HwpfM3BUZg0FtNz3osg7g6bUlCru0zTf2+9
         b3ei+/HSaCZoK60GRIQlVg8Y2SeCPQ57BXyCK3xfDOD1DSo4+bWVpLTlL9vPqaaRPN0/
         97B2TSoQwkebCFdpOF+Wh0pTpbB1Yg+j6wuuqwR2eEj5Uc8JG9ZOX2IuX12+74hnVzYX
         9pf++2Xz3+AtlKLjpyZhAsBMW+Oj3xbltQvDl+ZseBOjHuyrnn4F14ByQWg1VPjHmeuk
         bMRavhGvbGJhs6QtydyeG19hGHoU2J0Fd5zM/NcGncmyQvzbNpNECKNGbjNM86q05wCe
         qfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715627129; x=1716231929;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q6OWJvskzIIbw45+/i+3bkIRVAKtXhs9CdDBeK5iKrA=;
        b=LS0RwgY/F2veUYdgVfmMWOjtZI1Ty9Dz0PIR9nvfIgfnyPlnxEdb36fiIGEcHW6do9
         wSl+W6Usa277qNCxzWERdaUUg3WNuosKi3SRmGoAB6FUyuN5pFJtdKUUGc41EnMhj4Np
         xCHdyK3BiRgVHMFAFn2sV265BJJ1tBDioXJLdt7FqnHPsE84cKdAs+SRNyU4X5+8j03n
         LRsRMZO4+G4Jhbblh0ot0WuRnOE4/KW8j2H39748bjTVvgYX0lyu9IkdUEPmvHaMC9ig
         Aj1zYP+WOxJAJKbVVryVboCAFvjnKFMCz3sp5MZxmX5Oa6B1mAQuYHcCvJxkMcnkmbKk
         LFBw==
X-Gm-Message-State: AOJu0Yy9cg8+1/Xmk+NtSA8Hm+fxPQMXm0EcFKc7b5AIC4AnM3/75SEJ
	WN6bMH4pkLpza2tofyhz/oLryjgAOPuJVGw1I4XMO6A7VrGOxW5rAXzTYprr
X-Google-Smtp-Source: AGHT+IH1j6/Vw08+4LzKYaR4HIxQoYL3fMn50uMxwmiwcuw+9CIMhiiqx1ArobzXa6B4oDObMlHufA==
X-Received: by 2002:a05:6a00:2d05:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-6f4e0348519mr12907273b3a.25.1715627128543;
        Mon, 13 May 2024 12:05:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bccsm8339646b3a.170.2024.05.13.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 12:05:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------vyR4g01R9hwoNx0m0xaize7M"
Message-ID: <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
Date: Mon, 13 May 2024 12:05:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, OlteanV@gmail.com
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
 <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
 <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>

This is a multi-part message in MIME format.
--------------vyR4g01R9hwoNx0m0xaize7M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/24 11:55, Stephen Langstaff wrote:
> 
> OK, just confirmed that dsa_loop_bdinfo.c is not compiled to either a .o 
> or a .ko file when using the unmodified Makefiles.

Attached is a configuration that I use on a x86-64 VM for testing that 
is started with:

qemu-system-x86_64 \
         -s \
         -cpu "max" \
         -smp 4 \
         -kernel ~/dev/linux/arch/x86/boot/bzImage \
         -device pci-bridge,id=pci_bridge1,bus=pci.0,chassis_nr=1 \
         -drive 
file=debian.img,if=none,id=drive-virtio-disk0,format=qcow2 -device 
virtio-blk-pci,scsi=off,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
\
         -nographic \
         -append "root=/dev/vda1 console=ttyS0,115200 mitigations=off" \
         -net nic,model=e1000 -net tap,ifname=tap0

..

ip link set dev enp0s3 name eth0
modprobe dsa_loop_bdinfo
modprobe dsa_loop

ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode 
DEFAULT group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
     altname enp0s3
3: lan1@eth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state 
DOWN mode DEFAULT group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
4: lan2@eth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state 
DOWN mode DEFAULT group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
5: lan3@eth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state 
DOWN mode DEFAULT group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
6: lan4@eth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state 
DOWN mode DEFAULT group default qlen 1000
     link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
-- 
Florian

--------------vyR4g01R9hwoNx0m0xaize7M
Content-Type: text/plain; charset=UTF-8; name="x86-64_dsa.config"
Content-Disposition: attachment; filename="x86-64_dsa.config"
Content-Transfer-Encoding: base64

Q09ORklHX0tFUk5FTF9YWj15CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX1BPU0lYX01RVUVV
RT15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQpDT05GSUdfSVJR
X1RJTUVfQUNDT1VOVElORz15CkNPTkZJR19MT0dfQlVGX1NISUZUPTE2CkNPTkZJR19DR1JP
VVBTPXkKQ09ORklHX1JFTEFZPXkKQ09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX1NN
UD15CkNPTkZJR19OUl9DUFVTPTQKIyBDT05GSUdfU0NIRURfTUMgaXMgbm90IHNldApDT05G
SUdfSFpfMTAwMD15CiMgQ09ORklHX1JBTkRPTUlaRV9CQVNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfU1VTUEVORCBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUEkgaXMgbm90IHNldApDT05GSUdf
SUEzMl9FTVVMQVRJT049eQpDT05GSUdfS1ZNPXkKQ09ORklHX0tWTV9JTlRFTD15CkNPTkZJ
R19LVk1fQU1EPXkKIyBDT05GSUdfS1ZNX0hZUEVSViBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
Q0NPTVAgaXMgbm90IHNldApDT05GSUdfTU9EVUxFUz15CkNPTkZJR19NT0RVTEVfRk9SQ0Vf
TE9BRD15CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKQ09ORklHX01PRFZFUlNJT05TPXkKQ09O
RklHX1BBUlRJVElPTl9BRFZBTkNFRD15CkNPTkZJR19DTUE9eQpDT05GSUdfTkVUPXkKQ09O
RklHX1BBQ0tFVD15CkNPTkZJR19VTklYPXkKQ09ORklHX0lORVQ9eQpDT05GSUdfSVBfTVVM
VElDQVNUPXkKQ09ORklHX0lQX1BOUD15CkNPTkZJR19JUF9QTlBfREhDUD15CkNPTkZJR19J
UF9QTlBfQk9PVFA9eQpDT05GSUdfSVBfUE5QX1JBUlA9eQpDT05GSUdfSVBfTVJPVVRFPXkK
Q09ORklHX0lQX1BJTVNNX1YxPXkKQ09ORklHX0lQX1BJTVNNX1YyPXkKQ09ORklHX0lORVRf
VURQX0RJQUc9eQpDT05GSUdfVENQX0NPTkdfQURWQU5DRUQ9eQpDT05GSUdfVENQX0NPTkdf
QklDPXkKIyBDT05GSUdfVENQX0NPTkdfV0VTVFdPT0QgaXMgbm90IHNldAojIENPTkZJR19U
Q1BfQ09OR19IVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBWNiBpcyBub3Qgc2V0CkNPTkZJ
R19CUklER0U9bQpDT05GSUdfQlJJREdFX1ZMQU5fRklMVEVSSU5HPXkKQ09ORklHX05FVF9E
U0E9bQpDT05GSUdfVkxBTl84MDIxUT1tCkNPTkZJR19DRkc4MDIxMT15CkNPTkZJR19QQ0k9
eQpDT05GSUdfUENJRVBPUlRCVVM9eQpDT05GSUdfUENJX01TST15CkNPTkZJR19ERVZUTVBG
Uz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19GV19DRkdfU1lTRlM9eQpDT05G
SUdfRldfQ0ZHX1NZU0ZTX0NNRExJTkU9eQpDT05GSUdfTVREPXkKQ09ORklHX01URF9DTURM
SU5FX1BBUlRTPXkKQ09ORklHX01URF9CTE9DSz15CkNPTkZJR19NVERfQ0ZJPXkKQ09ORklH
X01URF9KRURFQ1BST0JFPXkKQ09ORklHX01URF9DRklfSU5URUxFWFQ9eQpDT05GSUdfTVRE
X0NGSV9BTURTVEQ9eQpDT05GSUdfTVREX0NGSV9TVEFBPXkKQ09ORklHX01URF9ST009eQpD
T05GSUdfTVREX0FCU0VOVD15CkNPTkZJR19NVERfVUJJPXkKQ09ORklHX01URF9VQklfR0xV
RUJJPXkKQ09ORklHX0JMS19ERVZfTE9PUD15CkNPTkZJR19CTEtfREVWX1JBTT15CkNPTkZJ
R19CTEtfREVWX1JBTV9TSVpFPTgxOTIKQ09ORklHX1ZJUlRJT19CTEs9eQpDT05GSUdfRUVQ
Uk9NXzkzQ1g2PXkKQ09ORklHX0JMS19ERVZfU0Q9eQpDT05GSUdfQkxLX0RFVl9TUj15CkNP
TkZJR19DSFJfREVWX1NHPXkKQ09ORklHX1NDU0lfVklSVElPPXkKQ09ORklHX0FUQT15CkNP
TkZJR19TQVRBX0FIQ0k9eQpDT05GSUdfU0FUQV9BSENJX1BMQVRGT1JNPXkKQ09ORklHX0FU
QV9QSUlYPXkKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfTkVUX0RTQV9MT09QPW0KIyBD
T05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9B
REFQVEVDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BR0VSRSBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfQUxBQ1JJVEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfQUxURU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTUFaT04g
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FNRCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfQVFVQU5USUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FS
QyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVRIRVJPUyBpcyBub3Qgc2V0CiMg
Q09ORklHX05FVF9WRU5ET1JfQlJPQURDT00gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX0NBVklVTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQ0hFTFNJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQ0lTQ08gaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0RFQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRExJTksgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0VNVUxFWCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfRVpDSElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9JODI1
WFggaXMgbm90IHNldApDT05GSUdfRTEwMDA9eQojIENPTkZJR19ORVRfVkVORE9SX01BUlZF
TEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01FTExBTk9YIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX01ZUkkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX05BVFNFTUkgaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX05FVFJPTk9NRSBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9PS0kg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1FMT0dJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfQlJPQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1Jf
UVVBTENPTU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JEQyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9WRU5ET1JfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfUkVORVNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUk9DS0VSIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9TRUVRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSUxB
TiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU0lTIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9TT0xBUkZMQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9TTVNDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TVE1JQ1JPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TVU4gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVO
RE9SX1RFSFVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVEkgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5E
T1JfV0laTkVUIGlzIG5vdCBzZXQKQ09ORklHX01ESU9fQklUQkFORz1tCkNPTkZJR19NRElP
X0JDTV9VTklNQUM9bQpDT05GSUdfTURJT19NU0NDX01JSU09bQpDT05GSUdfTURJT19USFVO
REVSPW0KIyBDT05GSUdfV0xBTiBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRURFVj15
CkNPTkZJR19JTlBVVF9NT1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9FVkRFVj15CkNP
TkZJR19NT1VTRV9QUzJfRUxBTlRFQ0g9eQpDT05GSUdfSU5QVVRfTUlTQz15CkNPTkZJR19J
TlBVVF9VSU5QVVQ9eQojIENPTkZJR19TRVJJT19TRVJQT1JUIGlzIG5vdCBzZXQKQ09ORklH
X1ZUX0hXX0NPTlNPTEVfQklORElORz15CkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19T
RVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUwX0RXPXkKQ09ORklHX0hX
X1JBTkRPTT15CkNPTkZJR19JMkM9eQpDT05GSUdfSTJDX0NIQVJERVY9eQpDT05GSUdfSTJD
X01VWD15CiMgQ09ORklHX0hXTU9OIGlzIG5vdCBzZXQKQ09ORklHX01GRF9TWVNDT049eQoj
IENPTkZJR19ISURfU1VQUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVVBQT1JUIGlz
IG5vdCBzZXQKQ09ORklHX1VJTz1tCkNPTkZJR19WSVJUSU9fUENJPXkKQ09ORklHX1ZJUlRJ
T19CQUxMT09OPXkKQ09ORklHX1ZJUlRJT19JTlBVVD15CkNPTkZJR19WSVJUSU9fTU1JTz15
CkNPTkZJR19WSVJUSU9fTU1JT19DTURMSU5FX0RFVklDRVM9eQpDT05GSUdfVkhPU1RfTkVU
PXkKIyBDT05GSUdfU1VSRkFDRV9QTEFURk9STVMgaXMgbm90IHNldAojIENPTkZJR19JT01N
VV9TVVBQT1JUIGlzIG5vdCBzZXQKQ09ORklHX0dFTkVSSUNfUEhZPXkKIyBDT05GSUdfTlZN
RU0gaXMgbm90IHNldApDT05GSUdfRVhUNF9GUz15CkNPTkZJR19KQkQyX0RFQlVHPXkKQ09O
RklHX0ZVU0VfRlM9eQpDT05GSUdfQ1VTRT15CkNPTkZJR19JU085NjYwX0ZTPXkKQ09ORklH
X0pPTElFVD15CkNPTkZJR19aSVNPRlM9eQpDT05GSUdfVURGX0ZTPXkKQ09ORklHX01TRE9T
X0ZTPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfQ09ORklHRlNf
RlM9eQpDT05GSUdfSkZGUzJfRlM9eQpDT05GSUdfVUJJRlNfRlM9eQpDT05GSUdfQ1JBTUZT
PXkKQ09ORklHX1NRVUFTSEZTPXkKQ09ORklHX1NRVUFTSEZTX0xaTz15CkNPTkZJR19TUVVB
U0hGU19YWj15CkNPTkZJR19ORlNfRlM9eQpDT05GSUdfTkZTX1YzX0FDTD15CkNPTkZJR19O
RlNfVjQ9eQpDT05GSUdfTkZTX1Y0XzE9eQpDT05GSUdfTkZTX1Y0XzI9eQpDT05GSUdfUk9P
VF9ORlM9eQpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz15CkNPTkZJR19OTFNfSVNPODg1OV8x
PXkKIyBDT05GSUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQKQ09ORklHX0NSQ19DQ0lUVD15CkNP
TkZJR19MSUJDUkMzMkM9bQpDT05GSUdfRE1BX0NNQT15CkNPTkZJR19DTUFfU0laRV9NQllU
RVM9MTYKQ09ORklHX0NNQV9BTElHTk1FTlQ9OQpDT05GSUdfUFJJTlRLX1RJTUU9eQpDT05G
SUdfRFlOQU1JQ19ERUJVRz15CkNPTkZJR19GUkFNRV9XQVJOPTEwMjQKQ09ORklHX0RFQlVH
X0ZTPXkKQ09ORklHX0RFQlVHX1JPREFUQV9URVNUPXkKIyBDT05GSUdfU1RSSUNUX0RFVk1F
TSBpcyBub3Qgc2V0Cg==

--------------vyR4g01R9hwoNx0m0xaize7M--

