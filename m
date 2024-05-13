Return-Path: <linux-kernel+bounces-178171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83E8C49F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165931F22099
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83578564F;
	Mon, 13 May 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EuEuIpBZ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081D2B9D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642259; cv=none; b=HyBkZUnwVoMDTNcjithdnhNghR6Br5HvRMQO2AjrQySW9Bw4ovya/Wviyi2Fe+GeowyR2OrF3grPoMYEYo6UUii0DpZJOUdxFRNuOcxrsFANb4vQ6M5vSDz8DIJhyuM7Wqq6+Q5mLuogiLJVWd4yqFY3F2IB09QdFQ98CQ1/SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642259; c=relaxed/simple;
	bh=8sFnwkIDJcTw29YECKZQzjAe1IutNxyRQnDAajustyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NF4MqvmJv10NDydB7lBqldHlOo/nRCOjCC/cdFuOa7gQNtBz9l07ADKB6tA1WkcUWXlculxUX72oMAqYxfd13+0/Rr65ZxUoYj/GyBRmkUkLLM8Wk0M6Su00BSNa1AIvjUfNU214aR6CMwnDvuGBK8ygVAQVCAkpjKQQh+eOEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=EuEuIpBZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed012c1afbso39989555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1715642255; x=1716247055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDihUHCvdxt2IeYI4uIVgM+JJKGx/hS/rMFzo2PjzSM=;
        b=EuEuIpBZYmjOoLdnMvVa3uy1KB0IgEYCeuiqFF+0+Zkv5cQqtQXcvO5EL2uDQ8wzV1
         fhS9DCEoiJIIjYAilzkfk0i5oAnaInPW9NzcbO4wKcbh/Yp0AVXx57CyPtx1hC5phLI2
         TXnkZ+wz2sMuZWGBXwMjK3eMqvW0F43+/zw17OLIwPPSVUx0necS8L7cu//Ekm+ApoZc
         vwx/DfnBtwzt8NKQbVdP97AMevjMiq/Ke1aPGQjBdxO7q1x5lsoa7F9W5MwxVzWPcd0I
         2DHOYq90qQXTcSqSWyhEFTqaA66SXYo6BzWjcmeSVjePePdOPS1abkWaSOid+LDnZqPz
         3jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642255; x=1716247055;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDihUHCvdxt2IeYI4uIVgM+JJKGx/hS/rMFzo2PjzSM=;
        b=BAt0A54yN1VLeJtDajf0cNHsDCWdkuc1ACTrd8gf8SKxMJ3YcTfoGYEDbUxPz09PIt
         BXiaO1vxYPfM/HdpxB4B+DotA53kOJo2I1fkEGMCDdn37G9RlAycxjK6yBcDhuGFLQyx
         y2KOMRC00qdPu3Q5J5B2xzCau5Wf8HFcuclJFuRBDxpuJuAJi0Q7YRMyk9cNhTrdKsu2
         NiOFVqgjGQRtiO0Nvik4Ckzu3hdUJqFMS5wYkfBs69SFifBGeryIpWNhEblRfKZKSOBs
         a+JoIl14M6ei0nhPem0Gpox9L52ieF33Q+LiZ8P7PwDRn/9vTwPvA0ns78ErDV0V32Vk
         10Wg==
X-Gm-Message-State: AOJu0YzDIMoTQoBM2pRjsrkaxv+cJjxrQeZ5psrbCDpUHiYalPpK3Ke4
	UXVoN0uBlvMrye4bFmp3p05W9S2L+GAY2N3/xRWbU+UlkJzwheencx02HmRS7eA=
X-Google-Smtp-Source: AGHT+IFFnZRJTVRyntxhf+EtmWKMusVyx3nhf1DT07cytdA+foeNpy4zjVFTT8kJK0pZYdZPVfYy0A==
X-Received: by 2002:a17:903:190:b0:1eb:d72e:82ae with SMTP id d9443c01a7336-1eefa03a3b3mr213467195ad.13.1715642255131;
        Mon, 13 May 2024 16:17:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30ca3sm84929035ad.151.2024.05.13.16.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:17:34 -0700 (PDT)
Date: Mon, 13 May 2024 16:17:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iporoute2 6.9 release
Message-ID: <20240513161732.4a4dd47a@hermes.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is regular release of iproute2 corresponding to the 6.9 kernel.
Release is smaller than usual, usual documentation and bug fixes.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.9.0.tar.=
gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Aahil Awatramani (1):
      ip/bond: add coupled_control support

Andrea Claudi (1):
      man: fix typo in tc-mirred man page

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      man: use clsact qdisc for port mirroring examples on matchall and mir=
red

Christian G=C3=B6ttsche (1):
      ss: add option to suppress queue columns

Date Huang (2):
      bridge: vlan: fix compressvlans usage
      bridge: vlan: fix compressvlans usage

David Ahern (2):
      Update kernel headers
      Update kernel headers

Denis Kirjanov (7):
      ifstat: convert sprintf to snprintf
      nstat: constify name argument in generic_proc_open
      nstat: use stack space for history file name
      nstat: convert sprintf to snprintf
      iproute2: move generic_proc_open into lib
      ifstat: handle strdup return value
      ifstat: don't set errno if strdup fails

Jiayun Chen (1):
      man: fix doc, ip link does support "change"

Justin Iurman (2):
      ip: ioam6: add monitor command
      man8: ioam: add doc for monitor command

Luca Boccassi (1):
      man: fix typo found by Lintian

Max Gautier (1):
      arpd: create /var/lib/arpd on first use

Quentin Deslandes (3):
      ss: add support for BPF socket-local storage
      ss: pretty-print BPF socket-local storage
      ss: update man page to document --bpf-maps and --bpf-map-id=3D

Stephen Hemminger (24):
      netlink: display information from missing type extack
      ifstat: support 64 interface stats
      rt_names: whitespace cleanup
      tc/action: remove trailing whitespace
      tc: make qdisc_util arg const
      tc: make filter_util args const
      tc: make action_util arg const
      tc: make exec_util arg const
      README: add note about kernel version compatibility
      netem: use 64 bit value for latency and jitter
      tc: remove no longer used helpers
      tc: support JSON for legacy stats
      pedit: log errors to stderr
      skbmod: support json in print
      simple: support json output
      tc-simple.8: take Jamal's prompt off examples
      uapi: update headers
      uapi: update vdpa.h
      ila: allow show, list and lst as synonyms
      mnl: initialize generic netlink version
      use missing argument helper
      uapi: update vdpa.h
      uapi: spelling fix for xfrm.h
      v6.9.0

Victor Nogueira (3):
      m_mirred: Allow mirred to block
      tc: add NLM_F_ECHO support for actions
      tc: Add NLM_F_ECHO support for filters

Yedaya Katsman (2):
      ip: Exit exec in child process if setup fails
      ip: Add missing options to route get help output

Yusuke Ichiki (1):
      man: fix brief explanation of `ip netns attach NAME PID`


