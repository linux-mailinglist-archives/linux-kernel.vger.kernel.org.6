Return-Path: <linux-kernel+bounces-557094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08823A5D394
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12CF16FF34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F093C30;
	Wed, 12 Mar 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uwwuwvXt"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A872594
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738149; cv=none; b=uZbRmDKh9ouuLmoFF5F0ucf/JqpUBw6uCYZxc5LyMGE3fJi2er4AmR0O/ZBKcDtXv1ta4f+NRQ5SI2kjAKu4ZEng8utP/JbiQPREkmAjJO4KJLjvnxaNDkA45KOBQvNBnA3n6dH8LLreWxQkn6CMgTqfd/DA+FGVXrf0xYm/qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738149; c=relaxed/simple;
	bh=9nqRa6Jn2nqUz6btXPo+D/hCjEWPIEti99h4NvspsTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDhvU9Qy+WEJxf5wCVWsigfcMW0/6/WDe9+Bc0DH9wOP25dnTkU6Tn9YcPuoZrvrv7VvULZsV9RZ4SyKiZUHZ7T9uVkz1jWaQGbh957znmowskFVKztyMsVB6Y9FnjRsa6VGsGR1MGsDhERAMV5X7gTE2nUZK78qnoWvjZhm7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uwwuwvXt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fb83e137so40589886d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741738145; x=1742342945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PekTY0zcxwSLtNhsPsIQdYT6yLesDiO3gX3SAJPcd5E=;
        b=uwwuwvXtn+8XQdxzGbru+LRd7fI/PW1lXXEsNI73z5tcT+6e1QWEXHWEu2WgE54WGv
         cRMPfIymT2LZ0osGOP8jCI5TEqt2GLEaNyBorNl2h5tBjUMdQF2rn8tvlhL5gVNjFvnj
         2+ya6Ym1vmYKZIIrrAHri3im3V6uLFEvcBBjQwn5x7hUTsKdudoZ+a5lXTn9Rjqo454G
         PbfWCoeYNgF5zKHJcpAanrGqVK8KTpEE6ORcHdz3DuwCrxl396YjrsZyaZF3d/4cu0wf
         S+lQ/2X4DWVzIbI547lrvzl+3t+N2u1qJiOWP2lZLih0B0BJPTKVXkfY/feBN1AvuReu
         8XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738145; x=1742342945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PekTY0zcxwSLtNhsPsIQdYT6yLesDiO3gX3SAJPcd5E=;
        b=PA+caW9hvo1+vw/fswfBMyzmEvce1c19S7PcZ2ZlCYJIGs8+VC04/yEhXYKx9BMpLD
         LBjCeAGGBgZ1H+LU/PrpUqB3OTR9aaFaqQXbd6N9SkLS3901h2hx7pqNl/JjA5RgctMb
         8EaU0p/rclbNzyvmMn4efxpuuo/MfWF7xht5UpjTdhQt7obOuxjL3T+koWoBb8/wddp1
         Wsii5Q7OAyJK4MI+ExaGltUPZbuI6naZTKNpGiN8SXnVdBDqozzSgApOJjHUAL/R9NDT
         H0K0kfBrZoSpYFnqT+9uTBdqj0VgKPZUfoXlguXA2yAxkKOc0wkiTOQHIoa+v/kTAhXp
         IL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUFX3gsxFgW+9SO0WpS5gRugeN4JTaitKGQVDD+c7x9y5KQjuB6uNGqkzJCE8sM7B/TLkm8qu4OWf+t39k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvabloe0VbpxeK/Kmy2CRnihdf0dX5LIOiIo7dGLzMKDR7dYU
	4N3UDSToJyzpJC/zgqMzl4er6kDGB7ZOqmn1Fo51MQ9OQ3LVAlJQ3LxasEvBW2itV2VL0wkb2Lr
	L
X-Gm-Gg: ASbGncvvzuQo9HI134EkIaTtWeug2y9FkCOiDNvoTsNDcWZ+Hl3X9PBz2qvm85roxWq
	0oPXoebzuAnUulTZBS690vd18zvWyNTbutXnYRjDNFsYRFK2f0KZzmYdqvSqkDukuHkGlZ9FC6x
	Q6j3OTAxgdM8TLvwBGaGEcyhP/FQkLf9rg9xtNkaO9GOuFNIKK8a92ppWjI4GvbQ88m+Bidc81Q
	1NvAB0i9HWLaNwVfvcHuX7XU6OB7rI69YglyNw7nwjy7An20v8iQ1P3w2u8SFxqn7JnLaHvBqUS
	tsZCrIaitKEHH+2fn9I6d74aMD0quIzcjawExHvg1uRoqkMiOsdRcfZ6K4wVaaQuOA26afMWzKX
	i/fvqS2hXsPwnKfn2uHrDoyaRjBE=
X-Google-Smtp-Source: AGHT+IGFDHYU568m4lVr3D6L0XT0+a8ZiAWcAnSzN5e783DhPM6OBy5jnI3yA40bwtT9KMTQxoun3Q==
X-Received: by 2002:a05:6214:508f:b0:6e6:2395:7634 with SMTP id 6a1803df08f44-6e90061f1abmr280777026d6.27.1741738145052;
        Tue, 11 Mar 2025 17:09:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c5dcsm77692456d6.3.2025.03.11.17.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:09:04 -0700 (PDT)
Date: Tue, 11 Mar 2025 20:09:02 -0400
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>

In this section we'll cover a few different interleave mechanisms, some
of which require CXL decoder programming.  We'll discuss some of the
platform implications of hardware-interleave and how that affects driver
support, as well as software-based interleave.

Terminology
- Interleave Ways (IW):  Number of downstream targets in the interleave

- Interleave Granularity (IG):  The size of the interleaved data
                                (typically 256B-16KB, or 1 page)

- Hardware Interleave: Interleave done in CXL decoders

- Software Interleave: Interleave done by Linux (mempolicy, libnuma).

--------------------------------
Hardware Vs Software Interleave.
--------------------------------
CXL Hardware interleave is a memory interleave mechanism which utilizes
hardware decoders to spread System Physical Address accesses across a
number of devices transparent to the operating system.  A similar
technique is used on DRAM attached to a single socket.

We imagine physical memory as a linear construct, where physical address
implies the use of a specific piece of hardware.  In reality, hardware
interleave spreads access (typically at some multiple of cache line
granularity) across many devices to make better use bandwidth.

Imagine a system with 4GB of RAM in the address range 0x0-0xFFFFFFFF.
We often think of this memory linearly, where the first 2GB might be
the first DIMM and the second 2GB belong to the next.  But in reality,
when hardware interleave is in use, it may spread cache lines per-dimm.

     Simple Model                    Reality
    ---------------              ---------------
    |    DIMM0    |  0x00000000  |    DIMM0    |
    |    DIMM0    |              |    DIMM1    |
    |    DIMM0    |     ...      |    DIMM0    |
    |    DIMM0    |              |    DIMM1    |
    |    DIMM1    |  0x80000000  |    DIMM0    |
    |    DIMM1    |              |    DIMM1    |
    |    DIMM1    |              |    DIMM0    |
    |    DIMM1    |              |    DIMM1    |
    ---------------              ---------------

Software interleave, by contrast, concerns itself with managing
interleave among multiple NUMA nodes - where each node has different
performance characteristics.  This is typically done on a page-boundary
and is enforced by the kernel allocation and mempolicy system.

You can visualize this as a series of allocation calls returning pages
on different nodes.  In reality this occurs on fault (first access)
instead of malloc, but this is an easier way to think about it.

    1:1 Interleave between two nodes.
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    ... and so on ...

These techniques are not mutually exclusive, and the granularity/ways
of interleave may differ between hardware and software interleave.

-----------------------------
Inter-Host-Bridge Interleave.
-----------------------------
Imagine we have a system configuration where we've placed 2 CXL devices
on their own dedicated Host Bridge.  Maybe each CXL device is capable of
a full x16 PCIE link, and we want to aggregate the bandwidth of these
devices by interleave across host bridges.

This setup will require the BIOS to create a CEDT CFMWS which reports the
intent to interleave across host bridges.  This is typically because the
chipset memory controller needs to be made aware of how to route accesses
to host bridge, which is platform specific.

In the follow case, the BIOS has configured as single 4GB memory region
which interleaves capacity across two Host Bridges (7 and 6).

```
CFMWS:
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
            First Target : 00000007           <- Host Bridge _UID
             Next Target : 00000006           <- Host Bridge _UID
```

Assuming no other CEDT or SRAT entries exist, this will result in Linux
creating the following NUMA topology, where all CXL memory is in Node 1.

```
NUMA Structure:

         ----------     --------   |    ----------
         |  cpu0  |-----| DRAM |---|----| Node 0 |
         ----------     --------   |    ----------
        /         \                |
    -------     -------            |    ----------
    | HB0 |-----| HB1 |------------|----| Node 1 |
    -------     -------            |    ----------
       |           |               |
    CXL Dev     CXL Dev            |
```


In this scenario, we program the decoders like so:

```
Decoders:
                             CXL  Root
                                 |
                             decoder0.0
                            IW:2   IG:256
                     [0x300000000, 0x3FFFFFFFF]
                             /         \
                Host Bridge 7           Host Bridge 6
                /                                    \
           decoder1.0                             decoder2.0
          IW:1   IG:512                          IW:1   IG:512
  [0x300000000, 0x3FFFFFFFFF]             [0x300000000, 0x3FFFFFFFF]
               |                                      |
           Endpoint 0                             Endpoint 1
               |                                      |
           decoder3.0                             decoder4.0
          IW:2   IG:256                          IW:2   IG:256
  [0x300000000, 0x3FFFFFFFF]              [0x300000000, 0x3FFFFFFFF]
```

Notice the Host Bridge ways and granularity differ from the root and
endpoints. In the fabric (root through everything but endpoints),
Interleave ways are *target-count per-leg* and the granularity is the
parent's (IW * IG).

Host Bridge Decoder:
   IW = 1 = number of targets
   IG = 512 = Parent IW * Parent IG  (2 * 256)


-----------------------------
Intra-Host-Bridge Interleave.
-----------------------------
Now lets consider a system where we've placed 2 CXL devices on the same
Host Bridge.  Maybe each CXL device is only capable of x8 PCIE, and we
want to make full use of a single x16 link.

This setup only requires the BIOS to create a CEDT CFMWS which reports
the entire capacity of all devices under the host bridge, but does not
need to set up any interleaving.

In the follow case, the BIOS has configured as single 4GB memory region
which only targets the single host bridge, but maps the entire memory
capacity of both devices (2GB).

```
CFMWS:
          Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000300000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00                 <- No host bridge interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge _UID
```

Assuming no other CEDT or SRAT entries exist, this will result in linux
creating the following NUMA topology, where all CXL memory is in Node 1.

```
NUMA Structure:
        ---------     --------   |    ----------
        | cpu0  |-----| DRAM |---|----| Node 0 |
        ---------     --------   |    ----------
            |                    |
         -------                 |    ----------
         | HB0 |-----------------|----| Node 1 |
         -------                 |    ----------
        /       \                |
   CXL Dev     CXL Dev           |
```

In this scenario, we program the decoders like so:
```
Decoders
                           CXL Root
                              |
                          decoder0.0
                         IW:1  IG:256
                  [0x300000000, 0x3FFFFFFFF]
                              |
                          Host Bridge
                              |
                          decoder1.0
                         IW:2  IG:256
                   [0x300000000, 0x3FFFFFFFF]
                             /   \
                   Endpoint 0     Endpoint 1
                       |              |
                   decoder2.0     decoder3.0
                 IW:2  IG:256     IW:2  IG:256
    [0x300000000, 0x3FFFFFFFF]    [0x300000000, 0x3FFFFFFFF]
```

The root decoder in this scenario does not participate in interleave,
it simply forwards all accesses in this range to the host bridge.

The host bridge then applies the interleave across its connected devices
and the decodes apply translation accordingly.

-----------------------
Combination Interleave.
-----------------------
Lets consider now a system where 2 Host Bridges have 2 CXL devices each,
and we want to interleave the entire set.  This requires us to make use
of both inter and intra host bridge interleave.

First, we can interleave this with the a single CEDT entry, the same as
the first inter-host-bridge CEDT (now assuming 1GB per device).

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
            First Target : 00000007           <- Host Bridge _UID
             Next Target : 00000006           <- Host Bridge _UID
```

This gives us a NUMA structure as follows:
```
NUMA Structure:

         ----------     --------    |   ----------
         |  cpu0  |-----| DRAM |----|---| Node 0 |
         ----------     --------    |   ----------
        /         \                 |
    -------     -------             |   ----------
    | HB0 |-----| HB1 |-------------|---| Node 1 |
    -------     -------             |   ----------
      / \         / \               |
  CXL0   CXL1  CXL2  CXL3           |
```

And the respective decoder programming looks as follows
```
Decoders:
                             CXL  Root
                                 |
                             decoder0.0
                            IW:2   IG:256
                      [0x300000000, 0x3FFFFFFFF]
                             /         \
                Host Bridge 7           Host Bridge 6
                /                                    \
           decoder1.0                             decoder2.0
          IW:2   IG:512                          IW:2   IG:512
  [0x300000000, 0x3FFFFFFFFF]             [0x300000000, 0x3FFFFFFFF]
            /    \                                  /    \
   endpoint0      endpoint1                endpoint2      endpoint3
      |               |                       |               |
  decoder3.0      decoder4.0              decoder5.0      decoder6.0
          IW:4  IG:256                            IW:4  IG:256
  [0x300000000, 0x3FFFFFFFF]              [0x300000000, 0x3FFFFFFFF]
```

Notice at both the root and the host bridge, the Interleave Ways is 2.
There are two targets at each level.  The host bridge has a granularity
of 512 to capture its parent's ways and granularity (`2*256`).

Each decoder is programmed with the total number of targets (4) and the
overall granularity (256B).

We might use this setup if each CXL device is capable of x8 PCIE, and
we have 2 Host Bridges capable of full x16 - utilizing all bandwidth
available.

---------------------------------------------
Nuance: Hardware Interleave and Memory Holes.
---------------------------------------------
You may encounter a system which cannot place the entire memory capacity
into a single contiguous System Physical Address range.  That's ok,
because we can just use multiple decoders to capture this nuance.

Most CXL devices allow for multiple decoders.

This may require an SRAT entry to keep these regions on the same node.
(Obviously the relies on your platform vendor's BIOS)

```
CFMWS:
         Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000300000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00                 <- No host bridge interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge 7

         Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000400000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00                 <- No host bridge interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge 7

SRAT:
        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001          <- NUMA Node 1
            Reserved1 : 0000
         Base Address : 0000000300000000  <- Physical Memory Region
       Address Length : 0000000080000000  <- first 2GB

        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001          <- NUMA Node 1
            Reserved1 : 0000
         Base Address : 0000000400000000  <- Physical Memory Region
       Address Length : 0000000080000000  <- second 2GB
```

The SRAT entries allow us to keep the regions attached to the same node.
```

NUMA Structure:
        ---------     --------   |    ----------
        | cpu0  |-----| DRAM |---|----| Node 0 |
        ---------     --------   |    ----------
            |                    |
         -------                 |    ----------
         | HB0 |-----------------|----| Node 1 |
         -------                 |    ----------
        /       \                |
   CXL Dev     CXL Dev           |
```

And the decoder programming would look like so
```
Decoders:
                               CXL  Root
                             /           \
                    decoder0.0           decoder0.1
                  IW:1  IG:256           IW:1  IG:256
    [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
                             \           /
                              Host Bridge
                             /           \
                    decoder1.0           decoder1.1
                  IW:2  IG:256           IW:2  IG:256
    [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
              /   \                                /   \
    Endpoint 0     Endpoint 1            Endpoint 0     Endpoint 1
        |              |                     |              |
    decoder2.0     decoder3.0            decoder2.1     decoder3.1
            IW:2 IG:256                          IW:2 IG:256
    [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
```

Linux manages decoders in relation to the associated component, so
decoders are N.M where N is the component and M is the decoder number.

If you look, you'll see each side of this tree looks individually
equivalent to the intra-host-bridge interleave example, just with one
half of the total memory each (matching the CFMWS ranges).

Each of the root decoders still has an interleave width of 1 because
they both only target one host bridge (despite it being the same one).


--------------------------------
Software Interleave (Mempolicy).
--------------------------------
Linux provides a software mechanism to allow tasks to to interleave its
memory across NUMA nodes - which may have different performance
characteristics.  This component is called `mempolicy`, and is primarily
operated on with the `set_mempolicy()` and `mbind()` syscalls.

These syscalls take a nodemask (bitmask representing NUMA node ids) as
an argument to describe the intended allocation policy of the task.

The following policies are presently supported (as of v6.13)
```
enum {
        MPOL_DEFAULT,
        MPOL_PREFERRED,
        MPOL_BIND,
        MPOL_INTERLEAVE,
        MPOL_LOCAL,
        MPOL_PREFERRED_MANY,
        MPOL_WEIGHTED_INTERLEAVE,
};
```

Let's look at `MPOL_INTERLEAVE` and `MPOL_WEIGHTED_INTERLEAVE`.

To quote the man page:
```
MPOL_INTERLEAVE
    This  mode  interleaves  page  allocations  across the nodes specified
    in nodemask in numeric node ID order.  This optimizes for bandwidth
    instead of latency by spreading out pages and memory accesses to those
    pages across multiple nodes.  However, accesses to a single page will
    still be limited to the memory bandwidth of a single node.

MPOL_WEIGHTED_INTERLEAVE (since Linux 6.9)
    This mode interleaves page allocations across the nodes specified in
    nodemask according to the weights in
        /sys/kernel/mm/mempolicy/weighted_interleave
    For example, if bits 0, 2, and 5 are set in nodemask and the contents of
        /sys/kernel/mm/mempolicy/weighted_interleave/node0
        /sys/ ... /node2
        /sys/ ... /node5
    are 4, 7, and 9, respectively, then pages in this region will be
    allocated on nodes 0, 2, and 5 in a 4:7:9 ratio.
```

To put it simply, MPOL_INTERLEAVE will interleave allocations at a page
granularity (4KB, 2MB, etc) across nodes in a 1:1 ratio, while
MPOL_WEIGHTED_INTERLEAVE takes into account weights - which presumably
map to the bandwidth of each respective node.

Or more concretely:

MPOL_INTERLEAVE
    1:1 Interleave between two nodes.
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    ... and so on ...

MPOL_WEIGHTED_INTERLEAVE
    2:1 Interleave between two nodes.
    malloc(4096)  ->  node0
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    malloc(4096)  ->  node0
    malloc(4096)  ->  node0
    malloc(4096)  ->  node1
    ... and so on ...

This is the preferred mechanism for *heterogeneous interleave* on Linux,
as it allows for predictable performance based on the explicit (and
visible) placement of memory.

It also allows for memory ZONE restrictions to enable better performance
predictability (e.g. keeping kernel locks out of CXL while allowing
workloads to leverage it for expansion or bandwidth).

======================
Mempolicy Limitations.
======================
Mempolicy is a *per-task* allocation policy that is inherited by
child-tasks on clone/fork. It can only be changed by the task itself,
though cgroups may affect the effective nodemask via cpusets.

This means once a task has been launched, and external actor cannot
change the policy of a running task - except possibly by migrating that
task between cgroups or changing the cpusets.mems value of the cgroup
the task lives in.

Additionally, If capacity on a given node is not available, allocations
will fall back to another node in the node mask - which may cause
interleave to become unbalanced.

================================
Hardware Interleave Limitations.
================================
Granularities:
   granularities are limited on hardware
   (typically 256B up to 16KB by power of 2)

Ways:
   Ways are limited by the CXL configuration to:
   2,4,8,16,3,6,12

Balance:
   Linux does not allow imbalanced interleave configurations
   (e.g. 3-way interleave where 2 targets are on 1 HB and 1 on another)

Depending on your platform vendor and type of interleave, you may not
be able to deconstruct an interleave region at all (decoders may be
locked).  In this case, you may not have the flexiblity to convert
operation from interleaved to non-interleave via the driver interface.

In the scenario where your interleave configuration is entirely driver
managed, you cannot adjust the size of an interleave set without
deconstructing the entire set.

------------------------------------------------------------------------

Next we'll discuss how memory allocations occur in a CXL-enabled system,
which may be affected by things like Reclaim and Tiering systems.

~Gregory

