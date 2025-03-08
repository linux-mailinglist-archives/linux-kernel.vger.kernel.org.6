Return-Path: <linux-kernel+bounces-552276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AFA577D9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9844E1899545
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206714EC60;
	Sat,  8 Mar 2025 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G3FIXI9/"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866512CDA5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404191; cv=none; b=b8K4OqUdS9QP0nvr9igzTqRe8KRh4TGx+EMFMnBbnnxIJFT2UCmSf+Kw7PqwQYMO+vMX62tO1s5tR+DgDF+F4NTStImU0uVALzat9HCg5GwhiAHY3FZSeBDSHp7bB+vk6vv7L2jyn5bICxRPFgpwMnOoSjc2XoFerfzQQybhKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404191; c=relaxed/simple;
	bh=MmzQsLxDKIXvY+Hbb0XgX5cimXDJJg45pGRDylUKdgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8EiVFEI6mhC8OTUEzL72m5jgzH1Ci3NKpc5YWEitH23MmyYi/VXDSI+BQegPWYZ5LpycNVi095VaiMxK39dUA9YzMZKJo6c+TH8BcMBbOQ55Sw43HdygbfzBUuqtwR9nUSw4VOPT/QICDBZiSlo59fKTQ0Ymz/5RANNkZHqNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G3FIXI9/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08b14baa9so237989085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741404188; x=1742008988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kkDaiYn8BNq9wXK9Bp+xqS98ju01c1lv7vbYke9egk=;
        b=G3FIXI9/QgS6b7p9ZKeChZXfnJbfsBaKwiMp3MmplqM0SDwuySwiSvtHDPpvk10lnl
         6ynhbpCsGWYhU8lLF8chc9f0yu4xylAyBYwok8uyb75bjsRGS5SX0Ev7QqqgwayENzZq
         IDiyceOQHhpG/vGc80p+phcoqOt/CTAU/Qee3bwbKNt4CFxuVTUa1jqcz4VNvJFAINqy
         eUzrnawfrKrohuqSEo17BDBsjkv4qKVsEGaDODprJ778umm5TV5MvVeMjLLWLraQGlnu
         3Ct56NtALTcoGsBOIFigi4+ykG2xeZFOLZsT4GhHVDgVnIwlhm4IxY8X41eVIcAsi6Kk
         hDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741404188; x=1742008988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kkDaiYn8BNq9wXK9Bp+xqS98ju01c1lv7vbYke9egk=;
        b=fvmBFKDzcnVKC4RFg/jWxfnm6QpgeHptSMpJP2RWlyZ5IXRf0+SW3It9gzRQPpWLid
         wdHK34D+44cCgEfxKaxlXDlWiYPYJL5vV3Zux0RZTi6+75O81iGSxYsRyJ9qyA/15FVS
         NbIVKwTmbtsUByOZ9/mJ1Nh4WmhA6IztC46fU/2qLFEi0UfgNiFggs82kI+fsEvpg8PT
         A58qB40EPvVeDxapK7B4OF30A4vBeVBO326CXjn5i+oPdAzKfDuIx3D+/hD1wqJyh0m/
         Xeefjzq89KJM0cI18if7U0ML6HZy/GNprgA+T5RDYVZD4YNcEHvRiT4gkbkHckfl3iaa
         dwDw==
X-Forwarded-Encrypted: i=1; AJvYcCX+LlmRk27Gt96ti8yhgUvHUqM2NhRTlyPtZDPsggUd2IpoFssPwdUKW8xzXk/9PW+bx+H5491TFOLueBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3oGu8D10chXFxD2uNlH/Oz5xwryVuc1zXwEgt/wqtU1z5K/m
	0JrHxt8r5AExapwk3l/zm5kqoNua+66pGpFhQ7qFujFQQYoFg+yQzk+ZqU9PRpusn6/Ul/UU8vL
	L
X-Gm-Gg: ASbGncsvk+j+Q8cSYO6X0hci6MJWkziTvfHzP1bbbpE28xqaSxzRxtzJABVb/sslWc8
	VEP3ATpZwjMQuhGlJj47v0QTGAb6L9c2UttTJB51egE+swyPUNv9x7cJff8ZxHsx0HmnLd3eGrY
	jj2bEeA87KFSb93qsb+0UpHCUmkAXgTi2fAQE1rgpdv6Y6gWEvJ7aaRinZ6lUlUuiypjhCfv5Ok
	a1ZiKoNh+MaLVLOvh91A84OR7J1h3IFr6CCcbd7KhuN87sUXDr9yMcNtWNV1ua/RkIB9i+SaIdF
	Tt3+dqVZZkM+u90XSh5XKn1K0r2kUeF1HuKQTKmUjuJIHg2dV1XaoAalu3RNO/GzluFIJ6ZHId2
	CXA+AN1NYEIZkagNgzeBa/nQmggE=
X-Google-Smtp-Source: AGHT+IEcBkI69lUrjBbxyKItEz6GSDDrzJ/inNMnbTU6xoigcZCvrVlOh6zAGVKFHLwBZbuUjdRTMg==
X-Received: by 2002:a05:620a:86ce:b0:7c3:d316:1d8e with SMTP id af79cd13be357-7c4e6194783mr917562385a.53.1741404187604;
        Fri, 07 Mar 2025 19:23:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534e924sm331448985a.39.2025.03.07.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 19:23:07 -0800 (PST)
Date: Fri, 7 Mar 2025 22:23:05 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA Flexiblity
Message-ID: <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>

In the last section we discussed how the CEDT CFMWS and SRAT Memory
Affinity structures are used by linux to "create" NUMA nodes (or at
least mark them as possible). However, the examples I used suggested
that there was a 1-to-1 relationship between CFMWS and devices or
host bridges.

This is not true - in fact, CFMWS are a simply a carve out of System
Physical Address space which may be used to map any number of endpoint
devices behind the associated Host Bridge(s).

The limiting factor is what your platform vendor BIOS supports.

This section describes a handful of *possible* configurations, what NUMA
structure they will create, and what flexibility this provides.

All of these CFMWS configurations are made up, and may or may not exist
in real machines. They are a conceptual teching tool, not a roadmap.

(When discussing interleave in this section, please note that I am
 intentionally omitting details about decoder programming, as this
 will be covered later.)


-------------------------------
One 2GB Device, Multiple CFMWS.
-------------------------------
Lets imagine we have one 2GB device attached to a host bridge.

In this example, the device hosts 2GB of persistent memory - but we
might want the flexibility to map capacity as volatile or persistent.

The platform vendor may decide that they want to reserve two entirely
separate system physical address ranges to represent the capacity.

```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000200000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 000A               <- Bit(3) - Persistant
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

NUMA effect: 2 nodes marked POSSIBLE (1 for each CFMWS)
```

You might have a CEDT with two CFMWS as above, where the base addresses
are `0x100000000` and `0x200000000` respectively, but whose window sizes
cover the entire 2GB capacity of the device.  This affords the user 
flexibility in where the memory is mapped depending on if it is mapped
as volatile or persistent while keeping the two SPA ranges separate.

This is allowed because the endpoint decoders commit device physical
address space *in order*, meaning no two regions of device physical
address space can be mapped to more than one system physical address.

i.e.: DPA(0) can only map to SPA(0x200000000) xor SPA(0x100000000)

(See Section 2a - decoder programming).

-------------------------------
Two Devices On One Host Bridge.
-------------------------------
Lets say we have two CXL 2GB devices behind a single host bridge, and we
may or may not want to interleave some or all of those devices.

There are (at least) 2 ways to provide this flexibility.

First, we might simply have two CFMWS.
```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000200000000   <- Memory Region
             Window size : 0000000080000000
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

NUMA effect: 2 nodes marked POSSIBLE (1 for each CFMWS)
```

These CFMWS target the same host bridge, but are NOT necessarily limited
to mapping memory from any one device. We could program decoders in
either of the following ways.

Example: Host bridge and endpoints are programmed WITHOUT interleave.
```
Decoders
                               CXL  Root
                             /           \
                    decoder0.0           decoder1.0
    [0x100000000, 0x17FFFFFFF]           [0x200000000, 0x27FFFFFFF]
                             \           /
                              Host Bridge
                             /           \
                    decoder2.0           decoder2.1
    [0x100000000, 0x17FFFFFFFF]           [0x200000000, 0x27FFFFFFF]
                        |                    |
                    Endpoint 0           Endpoint 1
                        |                    |
                    decoder4.0           decoder5.0
    [0x100000000, 0x17FFFFFFF]           [0x200000000, 0x27FFFFFFF]

NUMA effect:
   All of Endpoint 0 memory is on NUMA node A
   All of Endpoint 1 memory is on NUMA node B
```

Alternatively, these decoders could be programmed to interleave memory
accesses across endpoints.  We'll cover this configuration in-depth
later. For now, just know the above structure means that each endpoint
has its own NUMA node - but this is not required.


-------------------------------------------------------------
Two Devices On One Host Bridge - With and Without Interleave.
-------------------------------------------------------------
What if we wanted some capacity on each endpoint hosted on its own NUMA
node, and wanted to interleave a portion of each device capacity?

We could produce the following CFMWS configuration.
```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region 1
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000200000000   <- Memory Region 2
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000300000000   <- Memory Region 3
             Window size : 0000000100000000   <- 4GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

NUMA effect: 3 nodes marked POSSIBLE (1 for each CFMWS)
```

In this configuration, we could still do what we did with the prior
configuration (2 CFMWS), but we could also use the third root decoder
to simplify decoder programming of interleave.

Since the third region has sufficient capacity (4GB) to cover both
devices (2GB/each), we can actually associate the entire capacity of
both devices in that region.

We'll discuss this decoder structure in-depth in Section 4.


-------------------------------------
Two devices on separate host bridges.
-------------------------------------
We may have placed the devices on separate host bridges.

In this case we may naturally have one CFMWS per host bridge.

```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region 1
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000200000000   <- Memory Region 2
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000006           <- Host Bridge _UID

NUMA Effects: 2 NUMA nodes marked POSSIBLE
```

But we may also want to interleave *across* host bridges. To do this,
the platform vendor may add the following CFMWS (either by itself if
done statically, or in addition to the above two for flexibility).

```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000300000000   <- Memory Region
             Window size : 0000000100000000   <- 4GB
Interleave Members (2^n) : 01                 <- 2-way interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge 7
             Next Target : 00000006           <- Host Bridge 6

NUMA Effect: an additional NUMA node marked POSSIBLE
```

This greatly simplifies the decoder programming structure, and allows
us to aggregate bandwidth across host bridges.  The decoder programming
might look as follows in this setup.

```
Decoders:
                             CXL  Root
                                 |
                             decoder0.0
                    [0x300000000, 0x3FFFFFFFF]
                             /         \
                Host Bridge 7           Host Bridge 6
                /                                    \
           decoder1.0                             decoder2.0
  [0x300000000, 0x3FFFFFFFFF]             [0x300000000, 0x3FFFFFFFF]
               |                                      |
           Endpoint 0                             Endpoint 1
               |                                      |
           decoder3.0                             decoder4.0
  [0x300000000, 0x3FFFFFFFF]              [0x300000000, 0x3FFFFFFFF]
```

We'll discuss this more in-depth in section 4 - but you can see how
straight-forward this is.  All the decoders are programmed the same.

----------
SRAT Note.
----------
If you remember from the first portion of Section 0, the SRAT may be
used to statically assign memory regions to specific proximity domains.

```
        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001          <- NUMA Node 1
            Reserved1 : 0000
         Base Address : 000000C050000000  <- Physical Memory Region
       Address Length : 0000003CA0000000
```

There is a careful dance between the CEDT and SRAT tables and how NUMA
nodes are created.  If things don't look quite the way you expect - check
the SRAT Memory Affinity entries and CEDT CFMWS to determine what your
platform actually supports in terms of flexible topologies.

--------
Summary.
--------
In the first part of Section 0 we showed how CFMWS and SRAT affect how
Linux creates NUMA nodes.  Here we demonstrated that CFMWS are not a
1-to-1 relationship to either CXL devices or Host Bridges.

Instead, CFMWS are simply a System Physical Address carve out which can
be used in a number of ways to define your memory topology in software.

This is a core piece of the "Software Defined Memory" puzzle.

How your platform vendor decides to program the CEDT will dictate how
flexibly you can manage CXL devices in software.


~Gregory

