Return-Path: <linux-kernel+bounces-516055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B1A36C7C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E8A7A4EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBB1946C3;
	Sat, 15 Feb 2025 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9n3falZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6C192D6B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605106; cv=none; b=BT15Yrl1cmcnICD5g9M4EE0nb4wLqJFLks3nFUbop/UqbmdAvPbsHt6EuZFHh1O313/QdcB9g6yTkUlviiqjDf6CHjcRTAH9gbxnvj56Ts0tDxWK843KB0zxYZRPS6g0s+JiZnebCb5E0p4NXWV0ake0zozn15h2IXf3rg9b2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605106; c=relaxed/simple;
	bh=A4B2i7B49ydJtbyEYMGO2B7jgYoA6mb3cMiOBrTlUPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTRVSKdZ2FqXVBmlwzn0pAmrYJjKT/P7coayNDh3cxc9/93qBTXblFdBa+PBT3ch64J7UwMEAdA/BtdL8PPyCAAGJyHAZfOhQtx6MsIBKr7TnUorcgPKzXAxTYXpNiI8kNSmudzlpB5deY03bKmnsmR/dmvJbk8ZzQnknYAxNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9n3falZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739605103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWDjtb7Rhn51HfchEFLh7MLZr0T/SMf389ZL5QPUH0M=;
	b=B9n3falZrHXBZCLYsHjuZkI0+WmrqWTxwWko1hSy1OmuPi+VVK7pFnjt3X9VhqMyE+9rnP
	I+Pr7ZJOMAUYPZE2oCmXH3SPEWsPKQVPopE6/bo2ngGZvqjCYHZ3R6ZrdbxgqWnUtBaPzu
	+PYu1ArCUWlcJSB+L6mUraKaFeUNFIA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-VEOwihXsO12unT8s9RZC0w-1; Sat, 15 Feb 2025 02:38:21 -0500
X-MC-Unique: VEOwihXsO12unT8s9RZC0w-1
X-Mimecast-MFC-AGG-ID: VEOwihXsO12unT8s9RZC0w_1739605101
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e0412dd901so57979a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739605100; x=1740209900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWDjtb7Rhn51HfchEFLh7MLZr0T/SMf389ZL5QPUH0M=;
        b=hdy6VfvJWj5Rb3yveJ7HuDL6hwXzpyvhaJIOVGLmTdwujy7/qPZBhXFjSHDMFfw2Am
         BygpNbYf+6TiDNLdprn5l7gmWHGI8woU9QdMmJQh03a0U/3sKHaQTj4n6NlLyHp7Sssh
         5CGfdrVxIhyAIb3POyw6F2ODG+jKjPGeYNdOyiWTmSWKXJscA56V8H2oLgwJ8b8177Vw
         8l3aqWpghwUrID9qNjdDdLmhbEKIw7wgWF3+Wbomd2vz0uWu2zoiyCiedZyQpbmr1YE3
         WHGuPthUZ7lfm2vluKSrd2njXhG+c8ujBtUA4O77ESpcpiiVeiPOfyPI6cG5GlQMpNOR
         6RqA==
X-Gm-Message-State: AOJu0Ywcb/fViZDworWRQQwaQwGdh92J1CNt48BTSbCa5MceFSDWPW5M
	zYjaaYFheDzB1lc2SYYjsh9VqywfalTroiOoLQgqkD5nvgHrsvEjMndqeFB9fSl5JtVhAXqOs0V
	eEC/kfEqTdlpej7KgHHUyGf/fV1CD3XgdEWXZMSF+iQrUnZs/zen3nI6V0zPIbr1WE12CJ0acM4
	fa4wo214Ujl7724qOgp1CPbTIfGZa1IFjQ7xMrWTLlicfi
X-Gm-Gg: ASbGncssN+X3akr7ZcSEVLhcpnhZ3FEK3Z7pzrOxKqQ9q6u8+Q56hV4lc8ontp9nwiy
	ZZV0jxiQQt3b7S459vt0gxZwP2y+veEdyLW+/LEjSbRf56S89023SdpTmouoxbb/LU9NXMp2qnf
	fOsvokAtvhEMPuZLs4EclEtrkGf7+2MxSaxcP4R96GbY8n8WeAf4vV0HO474EYFb/1QGeq66Kpr
	lT2B4gZgOa5ITwcHsZNmckxSIYGR5Wm6xDfF7xLLOtcOEx4NS/hygnXWAeb7PaEhl3rusGFVunr
	9C0=
X-Received: by 2002:a05:6402:2114:b0:5e0:2996:7300 with SMTP id 4fb4d7f45d1cf-5e0361c8668mr1789941a12.20.1739605099734;
        Fri, 14 Feb 2025 23:38:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY1Jd8Xn9OrRCkMKnwl4e4BSKlBOGfI4udUpcfDESdHQdqzAx+ErE8yPbXqncelWxpQRVCsg==
X-Received: by 2002:a05:6402:2114:b0:5e0:2996:7300 with SMTP id 4fb4d7f45d1cf-5e0361c8668mr1789906a12.20.1739605098571;
        Fri, 14 Feb 2025 23:38:18 -0800 (PST)
Received: from kherbst.lan ([188.192.20.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ded69e7c33sm3195322a12.61.2025.02.14.23.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 23:38:14 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 1/1] MAINTAINERS: Remove myself
Date: Sat, 15 Feb 2025 08:37:53 +0100
Message-ID: <20250215073753.1217002-2-kherbst@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215073753.1217002-1-kherbst@redhat.com>
References: <20250215073753.1217002-1-kherbst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was pondering with myself for a while if I should just make it official
that I'm not really involved in the kernel community anymore, neither as a
reviewer, nor as a maintainer.

Most of the time I simply excused myself with "if something urgent comes
up, I can chime in and help out". Lyude and Danilo are doing a wonderful
job and I've put all my trust into them.

However, there is one thing I can't stand and it's hurting me the most.
I'm convinced, no, my core believe is, that inclusivity and respect,
working with others as equals, no power plays involved, is how we should
work together within the Free and Open Source community.

I can understand maintainers needing to learn, being concerned on
technical points. Everybody deserves the time to understand and learn. It
is my true belief that most people are capable of change eventually. I
truly believe this community can change from within, however this doesn't
mean it's going to be a smooth process.

The moment I made up my mind about this was reading the following words
written by a maintainer within the kernel community:

	"we are the thin blue line"

This isn't okay. This isn't creating an inclusive environment. This isn't
okay with the current political situation especially in the US. A
maintainer speaking those words can't be kept. No matter how important
or critical or relevant they are. They need to be removed until they
learn. Learn what those words mean for a lot of marginalized people. Learn
about what horrors it evokes in their minds.

I can't in good faith remain to be part of a project and its community
where those words are tolerated. Those words are not technical, they are
a political statement. Even if unintentionally, such words carry power,
they carry meanings one needs to be aware of. They do cause an immense
amount of harm.

I wish the best of luck for everybody to continue to try to work from
within. You got my full support and I won't hold it against anybody trying
to improve the community, it's a thankless job, it's a lot of work. People
will continue to burn out.

I got burned out enough by myself caring about the bits I maintained, but
eventually I had to realize my limits. The obligation I felt was eating me
from inside. It stopped being fun at some point and I reached a point
where I simply couldn't continue the work I was so motivated doing as I've
did in the early days.

Please respect my wishes and put this statement as is into the tree.
Leaving anything out destroys its entire meaning.

Respectfully

Karol

Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353de..ca31e57fa203c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7431,7 +7431,6 @@ F:	Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
 F:	drivers/gpu/drm/panel/panel-novatek-nt36672a.c
 
 DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
-M:	Karol Herbst <kherbst@redhat.com>
 M:	Lyude Paul <lyude@redhat.com>
 M:	Danilo Krummrich <dakr@kernel.org>
 L:	dri-devel@lists.freedesktop.org
@@ -24062,7 +24061,6 @@ F:	tools/testing/selftests/ftrace/
 TRACING MMIO ACCESSES (MMIOTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
-R:	Karol Herbst <karolherbst@gmail.com>
 R:	Pekka Paalanen <ppaalanen@gmail.com>
 L:	linux-kernel@vger.kernel.org
 L:	nouveau@lists.freedesktop.org
-- 
2.48.1


