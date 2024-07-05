Return-Path: <linux-kernel+bounces-242262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC642928571
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B6D283F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F481148309;
	Fri,  5 Jul 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVa3l7Tc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243E1474CB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172974; cv=none; b=NoDra7sjv+66wHwy5PflxRfAJ4ejVUj38xTS7RGQsbaoy/lpyuHajiteUeJOs1GnTokNL2NDOXYr7vni7steUWXb2yHLK3uOJ8Sx0FNeAlFXvfLbPHfv7GMHon72umBG6//zZkIdCzWPH+XEilj4VGsupcUErZzykb/54DsYNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172974; c=relaxed/simple;
	bh=wsYCwuM8ix2qrns9/jejbHm157Hrr7trZFphfMtDuSM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxGV7OHancch5xBBXTIWZ6gF9HaEsQ84z2LHRE2Bf3ft1bAignpPyINUjPz+kTSXzAqMNPeJVh6baa6MGf04w0ZSzuqawvKm9t5daLWq+MpGCXWwBgGjVd6B+HF2WU2XHG+8CgPfWz2/iVxzMJ8dN1lxEZ3oF5nUUIgvF3NU84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVa3l7Tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720172969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lT92jIdBnO5HWQZL4k8AfwOptFuoOzav8+401JaH/vw=;
	b=PVa3l7TcbCRUoKHW381zO/tk+gSpOMyRdiukYIpDHVWlEzOYoHIvT2l8T6VhUSfwXaPN6c
	vss8h2s9w0r7aXEWqs5ZE8cYZLCur2VHZWZrcYW0sNjbdvECIetpqg2yQYC5Na79PLe6JM
	xUPs7CPLnyIMtLppbT+mPT1xl/C0DFk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-tudduru7PoudPSyZfwunRg-1; Fri, 05 Jul 2024 05:49:28 -0400
X-MC-Unique: tudduru7PoudPSyZfwunRg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b5e96477ebso20185146d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172967; x=1720777767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT92jIdBnO5HWQZL4k8AfwOptFuoOzav8+401JaH/vw=;
        b=FPnDlsLys7M6sGU4O65tnydEDqaSbC8sofpnlb7nZ1CIVxQkknXRPgzdQZqkivWpR4
         a20VCTNi0D5sD/CYAfKhy+sHz+4pY3BFhsQY34Zi9+iAoqamzFgX1CQbxLUhFlA00VmZ
         4dRrC++Yi8oVrKfxmLzcvumjZmho/itCGU3dOjsc7xVFfWTPXaMtsOIOQ+xb3dIij8Q5
         kNSgYxucgY3VOa4r7OARy6uKSZX3o14sXEePE3lFeLJAQK5jAa5pWNfZ+HASX99Agxk9
         vrzU/ZNK1iDV8RhlWonIfvPtl0Hb9aNn9D61sKkW/M9HHSK9NHeQSygK+o51ke5FjJm5
         zMwg==
X-Forwarded-Encrypted: i=1; AJvYcCVE4Fq/3gH0jupYQpPO9FsM3b0yLewx7x/gV3CpsM620Jblh8SvFi5okKjVp+9slG+g3zEjQnGa6HBIu36+22KmQKiYAHAh8bag+w4+
X-Gm-Message-State: AOJu0YxS5BkAPOlvmJUulgRHgAhOcUixb61799UZpsb61bTtjVR2sg51
	V7Cz1vs9kmnnKKFy4yTlP9/ZaHi8cw6E8Y6FLNFUgsa2zcFSepnqZ8hVTvkVjiSLR3geW4AqdZN
	lhSHTbCPr69h7+s6M+uGimBa1A5ZN1W6diecC0ffEnkCr/9tqX1+4gD59rxwnp/N/AUNn455d/D
	mA8Xr2cJTI37qnmT7x/+iU98DflgTxWOUWTiOT
X-Received: by 2002:a05:6214:19c8:b0:6b5:8f73:acea with SMTP id 6a1803df08f44-6b5ecfbbfbamr54090396d6.25.1720172967604;
        Fri, 05 Jul 2024 02:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG780/DbEP3QU0RZ4oL+/iTzw4ZZdWD3YxsUTi7Ol59OZfhUS4ezoijm0HALdxuvelMUGp3mymNniA5BOKIf/c=
X-Received: by 2002:a05:6214:19c8:b0:6b5:8f73:acea with SMTP id
 6a1803df08f44-6b5ecfbbfbamr54090316d6.25.1720172967281; Fri, 05 Jul 2024
 02:49:27 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 09:49:26 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240704085710.353845-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240704085710.353845-1-amorenoz@redhat.com>
Date: Fri, 5 Jul 2024 09:49:26 +0000
Message-ID: <CAG=2xmPbJ5gQg4enf_B-Nfw5gnBSLTL89z44=P5X6NrrZsX4Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 00/10] net: openvswitch: Add sample multicasting.
To: netdev@vger.kernel.org
Cc: aconole@redhat.com, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 10:56:51AM GMT, Adrian Moreno wrote:
> ** Background **
> Currently, OVS supports several packet sampling mechanisms (sFlow,
> per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
> userspace action that needs to be handled by ovs-vswitchd's handler
> threads only to be forwarded to some third party application that
> will somehow process the sample and provide observability on the
> datapath.
>
> A particularly interesting use-case is controller-driven
> per-flow IPFIX sampling where the OpenFlow controller can add metadata
> to samples (via two 32bit integers) and this metadata is then available
> to the sample-collecting system for correlation.
>
> ** Problem **
> The fact that sampled traffic share netlink sockets and handler thread
> time with upcalls, apart from being a performance bottleneck in the
> sample extraction itself, can severely compromise the datapath,
> yielding this solution unfit for highly loaded production systems.
>
> Users are left with little options other than guessing what sampling
> rate will be OK for their traffic pattern and system load and dealing
> with the lost accuracy.
>
> Looking at available infrastructure, an obvious candidated would be
> to use psample. However, it's current state does not help with the
> use-case at stake because sampled packets do not contain user-defined
> metadata.
>
> ** Proposal **
> This series is an attempt to fix this situation by extending the
> existing psample infrastructure to carry a variable length
> user-defined cookie.
>
> The main existing user of psample is tc's act_sample. It is also
> extended to forward the action's cookie to psample.
>
> Finally, a new OVS action (OVS_SAMPLE_ATTR_PSAMPLE) is created.
> It accepts a group and an optional cookie and uses psample to
> multicast the packet and the metadata.
>
> --
> v8 -> v9:
> - Rebased.
>
> v7 -> v8:
> - Rebased
> - Redirect flow insertion to /dev/null to avoid spat in test.
> - Removed inline keyword in stub execute_psample_action function.
>
> v6 -> v7:
> - Rebased
> - Fixed typo in comment.
>
> v5 -> v6:
> - Renamed emit_sample -> psample
> - Addressed unused variable and conditionally compilation of function.
>
> v4 -> v5:
> - Rebased.
> - Removed lefover enum value and wrapped some long lines in selftests.
>
> v3 -> v4:
> - Rebased.
> - Addressed Jakub's comment on private and unused nla attributes.
>
> v2 -> v3:
> - Addressed comments from Simon, Aaron and Ilya.
> - Dropped probability propagation in nested sample actions.
> - Dropped patch v2's 7/9 in favor of a userspace implementation and
> consume skb if emit_sample is the last action, same as we do with
> userspace.
> - Split ovs-dpctl.py features in independent patches.
>
> v1 -> v2:
> - Create a new action ("emit_sample") rather than reuse existing
>   "sample" one.
> - Add probability semantics to psample's sampling rate.
> - Store sampling probability in skb's cb area and use it in emit_sample.
> - Test combining "emit_sample" with "trunc"
> - Drop group_id filtering and tracepoint in psample.
>
> rfc_v2 -> v1:
> - Accommodate Ilya's comments.
> - Split OVS's attribute in two attributes and simplify internal
> handling of psample arguments.
> - Extend psample and tc with a user-defined cookie.
> - Add a tracepoint to psample to facilitate troubleshooting.
>
> rfc_v1 -> rfc_v2:
> - Use psample instead of a new OVS-only multicast group.
> - Extend psample and tc with a user-defined cookie.
>
> Adrian Moreno (10):
>   net: psample: add user cookie
>   net: sched: act_sample: add action cookie to sample
>   net: psample: skip packet copy if no listeners
>   net: psample: allow using rate as probability
>   net: openvswitch: add psample action
>   net: openvswitch: store sampling probability in cb.
>   selftests: openvswitch: add psample action
>   selftests: openvswitch: add userspace parsing
>   selftests: openvswitch: parse trunc action
>   selftests: openvswitch: add psample test
>
>  Documentation/netlink/specs/ovs_flow.yaml     |  17 ++
>  include/net/psample.h                         |   5 +-
>  include/uapi/linux/openvswitch.h              |  31 +-
>  include/uapi/linux/psample.h                  |  11 +-
>  net/openvswitch/Kconfig                       |   1 +
>  net/openvswitch/actions.c                     |  66 ++++-
>  net/openvswitch/datapath.h                    |   3 +
>  net/openvswitch/flow_netlink.c                |  32 ++-
>  net/openvswitch/vport.c                       |   1 +
>  net/psample/psample.c                         |  16 +-
>  net/sched/act_sample.c                        |  12 +
>  .../selftests/net/openvswitch/openvswitch.sh  | 115 +++++++-
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 272 +++++++++++++++++-
>  13 files changed, 566 insertions(+), 16 deletions(-)
>
> --
> 2.45.2
>

Hi,

Simon Horman has spotted that openvswitch.sh tests are failing in the
debug executor:

https://netdev.bots.linux.dev/contest.html?test=3Dopenvswitch-sh

The failing tests are two: psample and upcall_interfaces. These two
tests have a known source of instability (they use "sleep") that make
them specially unreliable in slow systems.

Aaron and I already discussed this and I'm working on a patch to make
both tests more robust by adding a wait-and-retry mechanism.

I hope this series can be considered regardless of this flaky tests.

Thanks.
Adri=C3=A1n


