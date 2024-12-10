Return-Path: <linux-kernel+bounces-439110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A7A9EAAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30E016643F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E75819D897;
	Tue, 10 Dec 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGtXbCzR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C624230D18
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820273; cv=none; b=LFNePATj4J3L9s5yjDnoKhrNYYHGBqR8gX9M5BuVK9GWcKHT73Ejqzn06g/kUAl4SUoiviiQ9Wjr+Y2w4uzyBe9naSNCm9WmpYxIflzx7epVbsg8Qzg5B8+bRqRgECvFggBxTGL/QF9oBnzSo8OgKhgxJ5PMLa26/QAZLsQZxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820273; c=relaxed/simple;
	bh=JWLz+tgbhgfs4Gats6rTRa+7k8qgXJyOAENCx2C0cd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6Q9mJMSBQJN54Z9ZLJeYyo17K4fTPUMs2XtCoAxgs4sPTXS+MBDG/IjSjJaDZtCZqwdq+CXHlGJrSK+winZgpMODLAb+8G1G5uuUdqQ8vrlyPTraANfPOj6q38Aom8nEQcnP8sekKNE5XKQQURBmfKf9/nFO50ohYB4csu9w4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGtXbCzR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733820270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvGth1QLNyFinm1dsOjrasK+ZrrCmJs8ywoSm1iafao=;
	b=AGtXbCzRNyxI5m450HKEwPuKkzrFQEfrJawGwcUMISdZH11O6OycnZgdogr9Dd/WyWitQq
	WsPsSww8UMKRUlk/ofSAw62Eulbyh3PjNONUzSF1b4Q7TLlmyuWnKMFRusfelJFqs0VHQe
	8PmTrEDFrAjSSAsq+D+ghPicZMVbh0o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-0M-iex6MM0ayGOvsxPLKug-1; Tue,
 10 Dec 2024 03:44:26 -0500
X-MC-Unique: 0M-iex6MM0ayGOvsxPLKug-1
X-Mimecast-MFC-AGG-ID: 0M-iex6MM0ayGOvsxPLKug
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E77B19560A1;
	Tue, 10 Dec 2024 08:44:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.222])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05FE419560A2;
	Tue, 10 Dec 2024 08:44:20 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_yuzha@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	quic_cjhuang@quicinc.com,
	vbenes@redhat.com
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations are supported
Date: Tue, 10 Dec 2024 09:44:19 +0100
Message-ID: <20241210084419.126723-1-jtornosm@redhat.com>
In-Reply-To: <db61f998-2524-4623-8b0f-143661507e38@quicinc.com>
References: <db61f998-2524-4623-8b0f-143661507e38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

> Yes, Can you pls share the complete steps and commands?
Sure, I offered it before.

You need NetworkManager and of course NetworkManager-wifi packages installed
and working.
We are using Fedora/rhel with the default configuration and you can configure,
before the next steps, the wifi interface as sta from NetworkManager or not
(with no wifi configuration the same result happens) because it is going to
be unmanaged.

After booting (wlp1s0 is the wifi interface for ath11k and there are no other
wifi cards in the system), here the necessary steps with our network
configuration:
# nmcli  device set wlp1s0 managed off
# ip link set wlp1s0 up
# ip link add name wifi_br0 type bridge
# ip addr add 192.168.254.1/24 dev wifi_br0
# ip link set wifi_br0 up
# iw dev wlp1s0 interface add wlp1s0_0 type __ap
# iw dev wlp1s0 interface add wlp1s0_1 type __ap
# systemd-run --unit hostapd1 hostapd -dd /tmp/hostapd1.conf
# systemd-run --unit hostapd2 hostapd -dd /tmp/hostapd2.conf
# dnsmasq \
    --pid-file=/tmp/dnsmasq_wireless.pid \
    --port=63 \
    --no-hosts \
    --interface=wifi_br0 \
    --bind-interfaces \
    --dhcp-range=192.168.254.2,192.168.254.205,60m \
    --dhcp-option=option:router,192.168.254.1 \
    --dhcp-leasefile=/var/lib/dnsmasq/hostapd.leases \
    --dhcp-lease-max=200

After booting I get the same issue just doing:
# nmcli  device set wlp1s0 managed off
# ip link set wlp1s0 up
And the step that you commented in a previous answer:
# iw dev wlp1s0 interface add wlp1s0_0 type __ap
# iw dev wlp1s0 interface add wlp1s0_1 type __ap
# hostapd hostapd1.conf &
# hostapd hostapd2.conf &

You can use whatever hostapd configuration (with the suitable interface name).

Thanks

Best regards
Jose Ignacio


