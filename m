Return-Path: <linux-kernel+bounces-211425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB06905176
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739DDB230C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D593416F0C3;
	Wed, 12 Jun 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BE+wMOC4"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DC6F2F0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192296; cv=none; b=vEbkUuNSsRuDhN5cC9yl3EPnpRwKDH66XGizRDB7wNu3RaUahujAPXivBjdpd/c97+72s61LWp/776uMWE3sG57/fpVsTcu3UIFlXCi+h8bjnuQLmuwQ1A1AHxcL60o2j6EvqE59rQl2e+RUco5SdqzQbRWPFBd62zQiQaw2Ea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192296; c=relaxed/simple;
	bh=10lsxUsANAnYetZLlu3kHdpg1HXTuYl2IsnIznvcsh8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type; b=li9IhseUSg9QT7n6RcBeK86+tBLtDZPUCl6CYiCUGuqgKG7yxTtgqHv0uzgQb2jA4RiKxjaIDHKDf+drYLKeD6yVKZzweFlE/bNus/XvlAafQzlQuxic54cDyluB+afABwiY7VPBkqhGYy5jA+9nrAIRi/f0fascFHefwb8Esis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BE+wMOC4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso733687a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718192294; x=1718797094; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etbAZKNU9ONfjEO1BpDgencJ2m8Xkhn7JyX62hBwg/w=;
        b=BE+wMOC4WPoe46UXmto7DjhEaJxX7c3SoYCVmlMJj6n6u0Nc00o4PE6cQXr9zjHOvD
         9R8Tu7HtDDAw5tTOiXAG6tmY2Bro6EEcbHOiXWnBEoMEj9OdM9x/wWKbQ8ZseEqT+pmd
         QJmszobeXtXJlAdrnLrTNVDZkZ808c2ZbbCeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192294; x=1718797094;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etbAZKNU9ONfjEO1BpDgencJ2m8Xkhn7JyX62hBwg/w=;
        b=BszGwU+YawETFU+IO56XUhq2RdsltATE2YgW6Psf6aRdcE7SlQyooNKvaf+FyW1iKP
         IgWh+0Kjrf523N0advor+N1N+8WDgIlbU/92zzbjEr6IOaUuikUFodjnMBD3A7pl7mFO
         ajX6kh6fQqhtc+Z2dwmNu9wLt6rs4DJkp6qcH2+8dJtEYAZSeVS9snOrHO10kzG1F/70
         3GbjWn2qVKoAdPftaZtYVEUl41OH/qF3Tj5jeh7fdwRRr2gs3S4cGvIpIyU3pJzdo/8o
         ZWwKLALZQi9324FYwm5Y8hFRlgrsPH18YOccv6YvltFTjeAqKSdvYltuLK6q4qc5vnc6
         wJAg==
X-Gm-Message-State: AOJu0YwgecFWjrJ8JgAbydhwbxpJaINL9vEsao6Xvp97LzwP1ifyRaWN
	splO4/P3+VVhgw7E81x1cv4OuyY/rHVUjaPgsg5dpV4De6WVRt56p0lS8pWfzw==
X-Google-Smtp-Source: AGHT+IGCjLijC2vL35AHringbNE/x3DQDliMKM9yus5e+RUnEYXjZTJplS+jKubqq4tiK0cpDKbGGg==
X-Received: by 2002:a17:902:d4d2:b0:1f7:2b3:3331 with SMTP id d9443c01a7336-1f83b7e4fddmr16192245ad.4.1718192294014;
        Wed, 12 Jun 2024 04:38:14 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fc06a5d2sm74392305ad.306.2024.06.12.04.38.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:38:12 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 0/2] pci/switch_discovery: Add new module to discover inter-switch P2P links
Date: Wed, 12 Jun 2024 04:27:34 -0700
Message-Id: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f7dfd061aafd191"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--0000000000005f7dfd061aafd191

A. Introductory definitions:

Virtual Switch: Broadcom(PLX) switches have a capability where a
single physical switch can be divided up into N number of virtual
switches at SOD. For example, a single physical switch with 64 ports
can be configured to appear to the host as 2 switches with 32 ports
each. This is a static configuration that needs to be done before the
switch boots, and cannot generally be changed on the fly. Now consider
a GPU in Virtual switch 1 and a NIC on Virtual switch 2. The key here
is that it's actually the same switch, and IF P2P is enabled between
the two virtual switches, then that would be almost infinite bandwidth
between the GPU and the NIC. However, today there is no way for the
host to know that, and host applications believe that any data
exchange between the GPU and NIC must go through host root port and
thus would be slow. Note: Any such P2P must follow ACS/IOMMU rules,
and has to be enabled in the Broadcom switches.

Inter Switch Link: While the current use-case is about the virtual
switch config above, this could also extend to physical switch, where
the two physical switches have, say, a x16 PCIe connection between
them.

B: Goal/Problem statement:

Goal 1: Summary: Provide user applications a means by which they can
discover two virtual switches to be part of the same physical switch
or when physical switches are physically connected to each other, so
that they can discover optimized data path for HPC/AI applications.

With the rapid progression of High Performance Computing (HPC) and
Artificial Intelligence (AI), it is becoming more and more common to
have complex topologies with multiple GPU, NIC, NVMe devices etc
interconnected using multiple switches.   HPC and AI libraries like
MPI, UCC, NCCL,RCCL, HCCL etc analyze this topology to build a
topology tree to optimize data path for collective operations like
all-reduce etc .

Example:

                             Host root bridge
                ---------------------------------------
                |                  |                  |
  NIC1 --- PCI Switch1        PCI Switch2        PCI Switch3 --- NIC2
                |                  |                  |
               GPU1 ------------- GPU2 ------------- GPU3

                               SERVER 1

In the simple picture above in Server1, Switch1, Switch2, Switch3
are all connected to the host bridge and each switch has a GPU
connected, and Switch1/3 each has a NIC connected.
In a typical AI setup, there are many such servers, each connected by
upper level network switch, and "rail optimized", ie, NIC1 of all
servers are connected to Ethernet Switch1, NIC2 connected to Ethernet
Switch2 etc (Ethernet switches are not shown in picture above)
The GPUs are connected among themselves by some backend fabric, like
NVLINK (NVIDIA).
Assume that in the above diagram, PCI Switch1  and PCI Switch3 are
virtual switches belonging to the same physical switch and thus a very
high speed data link exists between them, but today host applications
have no knowledge about that.
(This is a very simple example, and modern AI infrastructure can be
way more complex than that.)

Now for collective operations like all-reduce, the HPC/AI libraries
analyze the topology above and typically decide on a data path like
this: NIC1->GPU1->GPU2->GPU3-> NIC2 which is suboptimal, because
ideally data should come go in and out through the same NIC because of
"rail optimized" topology.
Some libraries do this:NIC1->GPU1->GPU2->GPU3-> GPU1->NIC1.
The applications do the above because they think data from GPU3 to
NIC1  needs to go through the host root port, which is very
inefficient. What they do not know is that Switch1 and Switch3 are the
same physical entity with virtually infinite bandwidth between them,
and with that, they would have chosen a path like:
NIC1->GPU1->GPU2->GPU3->NIC1, which is the most optimized in the above
example.

Goal 2: Extend Linux P2PDMA distance function pci_p2pdma_distance to
account for Virtual Switch and physical switches connected by inter
switch link. The current implementation of the function has no
knowledge of Virtual switch and inter switch link.
Consider the example below:

     -+  Root Port
      \+ Switch1 Upstream Port
         +-+ Switch1 Downstream Port 0
          \- Device A
      \+ Switch2 Upstream Port
         +-+ Switch2 Downstream Port 0
           \- Device B

Suppose Switch1 and Switch2 are virtual switches belonging  to the
same physical switch. Today P2PDMA distance between Device A and
Device B  will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE, as kernel has
no idea that switch1 and switch2 are actually physically connected to
each other.
We intend to fix that, so that pci_p2pdma_distance now takes into
account switch connectivity information.

C. FAQs

FAQ 1:  How does this feature work with ACS/IOMMU?
This feature does NOT add any new connectivity.  The inter-switch
/virtual switch connections already follow all ACS/IOMMU rules, and
only if allowed by ACS settings, they allow for data to follow a
shortcut connection between switches and bypass the root port. The
only thing this module does is provide the switch connection
information to application software and pci_p2pdma_distance clients,
so that they can make intelligent decisions for the data path.

FAQ 2:  Is this feature Broadcom specific and will it work for other
vendors?
The current implementation of the kernel module looks at Broadcom
Vendor specific extensions to determine if switch p2p is enabled.
Thus, the current implementation works only on Broadcom switches. That
being said, other vendors are free to extend/modify the code to
support their switch. The function names, code structure and sysfs path
that exposes the pci switch p2p is on purpose made generic, to allow for
extension of support to other vendors.

FAQ 3: Why can't applications read the Broadcom vendor specific
information directly from the config space? Why do we need the sysfs
path?
The vendor specific section of PCIe config space is not readable by
applications running in non-root mode, as such applications can only
read the first few bytes of the config space. Besides, reading the
vendor specific config space will not make the solution generic.

FAQ 4: Will applications still use the standard P2P model of
registering the provider, client etc?
Absolutely. All existing p2p api will work as is. All that this module
provides is information that a fast connection exists between switches
 and/or pci endpoints. To make the actual p2p DMA, application need
use existing p2p API and follow existing ACS/IOMMU rules

FAQ 5: Why can't we only modify the existing pci_p2pdma_distance
function, and expose a p2pdistance to userspace? Why do we need the
new sysfs entries for pci switch connectivity?
The existing HPC/AI libraries like MPI, UCC, NCCL,RCCL, HCCL etc work
not only with PCIe switches, but also with other kind of connectivity,
like TCP, network switches, infiniband and backend inter GPU
connectivity like NVLINK and AFL. Because of that, the libraries have
matured code that analyzes all the connections and entire topology to
determine the most optimal data path among nodes. Just using
pci_p2pdma_distance does not work for them, because there might be a
shorter path between two nodes using NVLINK or a network switch.  In
theory those libraries could be modified to use pci_p2pdma_distance
for PCIe connection and other method for other connection, but in
practice that is near impossible, as those changes are very intrusive
and those libraries have matured for a long time,. Their respective
maintainers are highly reluctant to make such a big change and rather
get only the missing information, that is whether two switches are
connected together. Broadcom has received such first hand feedback.
Forcing everyone to use p2pdistance only will defeat the whole purpose
of this module. However, we do want to support those libraries that
want to use pci_p2pdma_distance, and that is why we are extending
pci_p2pdma_distance function too. Thus, our goal here is to enable
existing libraries to get only the information they need, while having
means for new code or more flexible code to use pci_p2pdma_distance as
needed.

Shivasharan S (2):
  switch_discovery: Add new module to discover inter switch links
    between PCI-to-PCI bridges
  pci/p2pdma: Modify p2p_dma_distance to detect virtual P2P links

 .../driver-api/pci/switch_discovery.rst       |  52 +++
 MAINTAINERS                                   |  13 +
 drivers/pci/Kconfig                           |   1 +
 drivers/pci/p2pdma.c                          |  18 +-
 drivers/pci/switch/Kconfig                    |   9 +
 drivers/pci/switch/Makefile                   |   1 +
 drivers/pci/switch/switch_discovery.c         | 375 ++++++++++++++++++
 drivers/pci/switch/switch_discovery.h         |  44 ++
 8 files changed, 512 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/pci/switch_discovery.rst
 create mode 100644 drivers/pci/switch/switch_discovery.c
 create mode 100644 drivers/pci/switch/switch_discovery.h

-- 
2.43.0


--0000000000005f7dfd061aafd191
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBXYwggReoAMCAQICDFr9U6igf1QRzoaH1TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTMyNDhaFw0yNTA5MTAwOTMyNDhaMIGq
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIzAhBgNVBAMTGlNoaXZhc2hhcmFuIFNyaWthbnRlc2h3YXJh
MTYwNAYJKoZIhvcNAQkBFidzaGl2YXNoYXJhbi5zcmlrYW50ZXNod2FyYUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDulAFNbtc+tsB1JubfhUwbq5745iWy0PqA
tUlf8OsSpnKZPtpZ/P9TJL8MrXyDJN5GdKeVAvh1YAvXb2S0i90gW5qWZtFQ4MRMQwXKHvwdVCTj
NBVuju4wvuIk8TWSSWryDIa/KUmQEFgRethHXcwAGKVM2LV19E+RJxjbqcqBXqT20XVYJ+86q3gC
pKeDdMqs49aS4NkFAulUXfKMvwayi1/al6l6H6NjkYI9V+VAhd2Pw5dVGT1UGNnGenU1ASxrICxB
p1may//a5w+WwgjNTKaKkyc6n0c4ds/TIbS/qi/G87n1VXSpcJHiebcJy8WZCbvo6g9j0Ipsx9mZ
ZyjVAgMBAAGjggHoMIIB5DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsG
AQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAuY3JsMDIGA1UdEQQrMCmBJ3NoaXZhc2hhcmFuLnNyaWthbnRlc2h3
YXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOXk95+zAtIGGWGU9q37iyIJKcYMwDQYJKoZIhvcNAQEL
BQADggEBABd5fRmxw/2mYuimst/fZaHYCHDoiYauRKIOm2YcV+s/4xhvXJx0fFit4LzpW8EgTXQv
GQCCaJeSArd/ad3NUOhuQtVB5xOO5cHcCYpdb9gvRPzSZss4mN5OrQsOD6iH0lyg9zIQfhReghMc
Y0C0m8ndFGSil396kqXLgxfPWJ8LChptV9z3iLmGoxJa/gqhi4xu+Ql3ZcQqcP6YItbGOmGjXF/p
uwxVuxQ2ZLaLPPZF5H6t1UPCJRYZXbcjPQHXqFTijI0/1PIUtJy3gUmAsxZe+1n/rCqqCHE4rM+q
Xm1kxB5u/2AMUovVed0IK1+1PFQLP47vY8PfDbSkU4UXH0YxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxa/VOooH9UEc6Gh9UwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIJZt8YoGCLOg1ZeIlPXCjNr0k33kmKgq5Mz7gnZGFivHMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMjExMzgxNFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQDBIH9mkTOaF+32BoUgGwIjCf+Xf67oOMpeop9YmMPt+DPFQ0xh3Wgz9YdJAG6+oMMmnsih
7tQR6PDpoWg3oTdut1+2MdgDvo1XnPR+1tvEWgi5Xf+n3Vwo737dRoJu47kuwhXlnrzSv0zkpf6O
AXwTxj4nBgFd1unP0E+ixoEWV7BcxtyBkPhgwdCsEKhv8JqY/UHEtz+V5FjxX/MQxPP/dRj8L1mp
6ZKgVM7NeCFUoQ9nUw7qzdiwNQFr7ChShhBXk2Z6nWPblFyavetxSRiFWdhXgfG0vgYzp3Ul2kl8
MoFVTAf2lKoFwSvGkjDtB4obskP1YQlYmq/1sG2c64B/
--0000000000005f7dfd061aafd191--

