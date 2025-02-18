Return-Path: <linux-kernel+bounces-518928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219DA3965F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C073B8416
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C422E3E2;
	Tue, 18 Feb 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKBF5C3z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59C22DF9D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868860; cv=none; b=lxEWoM7enTVJqP4ZmsFG+Hz979tyRHDO+LGByl/DYIkz/5VtDiRHfqCNGLDRkAf70cnVmrHNB+r7KXaxp0yIGMRIk+aPD249CuUT5IMh/AyoHJqTVCxrAUuqeo3iIILY5agk/iP0gPBjRRl1N0H295s79JlMFxok2EDd7v0R3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868860; c=relaxed/simple;
	bh=jwI/lNP5dSvyttLJubFZYl0XG36disqSc5jQ94EQu84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxUJGPTSPm58p/qVW/3cuOiHskNGFb652bnn55meXFIIBj79USBQdLHac3LooTRnoUaMmM6ngLmnOOnLRyXEvKIqCQTc8r8COfSiNdvrknCwMYroVZ3R3lg7jQYXOyvuCSxqam+MnQFZK546Ci0XvweyIi/bMmi1ijaa9VycYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKBF5C3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ag0dHU2PJNcElfhJQr4ZktwRcHGH3gFXUMCanAlAuaQ=;
	b=NKBF5C3zCFNxCN/lHq5pgBds5lbOsGry6L1JgFS2BQSBkD0en/yNkDqX4jU85P/D1XFV1E
	VHbNhvokWSNzxeTt2h3Mzw4/d/1aS4SKk1nCVicVSfkOiltzMTy8cEwPqe0C745xKF0ui1
	vzmtbIVRnR02VhpaZvOQp9HIUNnSOQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-mMvusxBdNL-I1oUcOB70Ug-1; Tue, 18 Feb 2025 03:54:14 -0500
X-MC-Unique: mMvusxBdNL-I1oUcOB70Ug-1
X-Mimecast-MFC-AGG-ID: mMvusxBdNL-I1oUcOB70Ug_1739868854
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438da39bb69so46227625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868854; x=1740473654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag0dHU2PJNcElfhJQr4ZktwRcHGH3gFXUMCanAlAuaQ=;
        b=Wo28haRZEpVIuKUb20qibHqvw1AWmONI0rcDL40TquOA7Gsw2ob5nj4tuvBmSVsbao
         NXDFnAc5EaDIgtAfmhGfTrF7ZuGQTJvmPMdXHsi5r53N6Y/KY3BfRVUfDZmw1SZEmdJ7
         o1VzSmNsyKfj9VpVmVrft9Cg33X2iK0x6QUZIyb/KRlE+9NsB9fwbUlgj0iBCo+YKOaJ
         mYDCuJOlvfRsoHSpgvv9wb2qeSJdQQ9C8dS3hgvoAZQ9dGSM0JO4Wm9R7vefM0YPTLad
         /4XPM7p6LkNZk6Lp19vlUh9xjjDjALqVztk4p1SRsVZeCbZjaTq9eGhS98iI1N6YaVIA
         980Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFCoXHvDYNORcozwGXXN2L3AWj1BQN/mX/0fkR9KaLSiISRw5DJke7nAepkiguDr2PsAXHTP0FLXBWZj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUV3bXo7NenQMer7QHwBBfDdMr93u6AKE7OsQQrWSmu0DzRYCs
	OBGri4l5VA4ZsMUTBhna4EkBvUaTdzBedUkqdsE8g3Nlr24n5H7JC9ZdQeh984GuP5zeSHRdDwf
	3yFQN2pvksRuibCrdJm4rOeVBIebftW3d39pKrSMA7oYWrcDPlRjdcB8aZZbjlg==
X-Gm-Gg: ASbGncsJv7tP44PR96aYSS3b01HUEoJkmw4FaoglwY/enqcyG4erSsgcPzoB8wkrPeb
	+Rl8QtZcWSke5Mw79iJ0CL63k3tqW9KckYwQGzcwM3AmUOk/gFVN3i7Pikz3VM3jisAcLSBH6wW
	3QRuinuawg1Ayy/gzzXpFMckx85GH8sGGx+3KsVTsE2szInrYrIUP/jJ/4FGqKgT4aKKhqG2hAP
	4Eu5T/oJIEyXMH0WqCCuZPUBgwApI3wcQ1pTSD8y5Mi36JnlPwPFwL1+dDA6iJzl6ny6QhxhvJl
	HRhCksbVMQMkV+o3Qp3wvDRQUw5GhSdcEAQMdv1TmaKPEhLEiJcd1g==
X-Received: by 2002:a05:600c:3848:b0:439:63de:3611 with SMTP id 5b1f17b1804b1-4396e70c72emr96431935e9.24.1739868853696;
        Tue, 18 Feb 2025 00:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrzQUcLDdRMbQ9tpTOvarMcJ+9b/19xmbIKWDGHi26EJ7bkp2+quEuTCCvx3hfiQoyjF9vvQ==
X-Received: by 2002:a05:600c:3848:b0:439:63de:3611 with SMTP id 5b1f17b1804b1-4396e70c72emr96431525e9.24.1739868853107;
        Tue, 18 Feb 2025 00:54:13 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm43986245e9.31.2025.02.18.00.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:54:12 -0800 (PST)
Date: Tue, 18 Feb 2025 09:54:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 4/4] selftest/bpf: Add vsock test for sockmap
 rejecting unconnected
Message-ID: <6p7yfobgfnms4m77k7whp4k3ft7m2vhmroacsd3stxmbxzzrwk@pmtz656ldbxc>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-4-994b7cd2f16b@rbox.co>

On Thu, Feb 13, 2025 at 12:58:52PM +0100, Michal Luczaj wrote:
>Verify that for a connectible AF_VSOCK socket, merely having a transport
>assigned is insufficient; socket must be connected for the sockmap to
>accept.
>
>This does not test datagram vsocks. Even though it hardly matters. VMCI is
>the only transport that features VSOCK_TRANSPORT_F_DGRAM, but it has an
>unimplemented vsock_transport::readskb() callback, making it unsupported by
>BPF/sockmap.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 30 ++++++++++++++++++++++
> 1 file changed, 30 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 21793d8c79e12b6e607f59ecebb26448c310044b..05eb37935c3e290ee52b8d8c7c3e3a8db026cba2 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -1065,6 +1065,34 @@ static void test_sockmap_skb_verdict_vsock_poll(void)
> 	test_sockmap_pass_prog__destroy(skel);
> }
>
>+static void test_sockmap_vsock_unconnected(void)
>+{
>+	struct sockaddr_storage addr;
>+	int map, s, zero = 0;
>+	socklen_t alen;
>+
>+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
>+			     sizeof(int), 1, NULL);
>+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
>+		return;
>+
>+	s = xsocket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (s < 0)
>+		goto close_map;
>+
>+	/* Fail connect(), but trigger transport assignment. */
>+	init_addr_loopback(AF_VSOCK, &addr, &alen);
>+	if (!ASSERT_ERR(connect(s, sockaddr(&addr), alen), "connect"))
>+		goto close_sock;
>+
>+	ASSERT_ERR(bpf_map_update_elem(map, &zero, &s, BPF_ANY), "map_update");
>+
>+close_sock:
>+	xclose(s);
>+close_map:
>+	xclose(map);
>+}
>+
> void test_sockmap_basic(void)
> {
> 	if (test__start_subtest("sockmap create_update_free"))
>@@ -1131,4 +1159,6 @@ void test_sockmap_basic(void)
> 		test_skmsg_helpers_with_link(BPF_MAP_TYPE_SOCKHASH);
> 	if (test__start_subtest("sockmap skb_verdict vsock poll"))
> 		test_sockmap_skb_verdict_vsock_poll();
>+	if (test__start_subtest("sockmap vsock unconnected"))
>+		test_sockmap_vsock_unconnected();
> }
>
>-- 
>2.48.1
>


