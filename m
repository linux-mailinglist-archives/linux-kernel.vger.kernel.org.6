Return-Path: <linux-kernel+bounces-555813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DFA5BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1909E3ACFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2722577E;
	Tue, 11 Mar 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcFLopar"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CE1E2606
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687306; cv=none; b=ElI8yG8Dm5Sm+5+kUsIFYCJE2o6Z7qyX9nxsUCzIcJX6E/JleMryt/W0Msx2sn/e0r3dzSmPFyYrerbkwTKTUmNR/vgyMY38HA9uAXhrks+ygGOZn6DiN9Ee8OLaWG0wOVJQ2/ZVoyn8mkzbcU8b+oS16B4tCLZo7HKAaqIbKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687306; c=relaxed/simple;
	bh=nWPAfhRPvyOxhsczSmiyOuKDVYDhl25/eaHP1Fif16w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMcgxtQ8vLZW8gmsG0wKSq5MlTikjo28zUC2bd5TVsuoLqVs9KoVEyh9qGUBoU9ZE/Fr6qY/UDEesNvWQkZAIPmwYJj6CgHoGjQ5DQnTnCJCtzV+b5R1YiZzyX/J0SrpKCU6VNLYMlEh+zePSD0AEWdV1moK+CuePOmdlACAWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcFLopar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qp4CrAYKQo+4LRd4xuzYXPfxibVR96LFmVo4qXJtxW4=;
	b=JcFLopar/V5SUm0PdNvW7HhCFQ9U4SaR3Vf8Mjv0czSPmBH4+Bvus65TvpSaus5RpfwxXV
	Tv1/E88f0tp0voF5KxbAK1ZwkGwyBCafqF2bR9AwxgbQjbyhcFOq8/EtxeNEubu7P/0UwJ
	oABx2Ojzjl8CojHGGgn7LqXBvx/GvVM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-jTUa0_22NPq1Or0y-iFdCg-1; Tue, 11 Mar 2025 06:01:41 -0400
X-MC-Unique: jTUa0_22NPq1Or0y-iFdCg-1
X-Mimecast-MFC-AGG-ID: jTUa0_22NPq1Or0y-iFdCg_1741687301
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5da14484978so5710208a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687301; x=1742292101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp4CrAYKQo+4LRd4xuzYXPfxibVR96LFmVo4qXJtxW4=;
        b=Xqhn3RVacvukL71Vyy0AoTRTUcFVXm56iAe2fPFslikeYYfLyVH5+9rEy9D8MhlvD3
         d6arOAHMGEBhfRmb03p+2vHeA4ffotCWhC4joJrwRG1Ujaf2yR2hqV67LrPosBtu+SD7
         R9YwCrDNYzabXFxyC6DYD56S4dz9N8TzYtvi+DvvbUBoIHeLIGKkG6lvlijN8/vzLDxg
         cIYyFfGwFTN1jkO5JJyC1LC9TzlHWKPYIi/9OLKCFuDu0nleWgya4HVaFpYLYdcbNEvG
         wgY4dBksVdd9nVXWndzcOVh9zFdNGzQ0QIPXx2kHjG1UQXjQKumpilhI4+dvpD7lrNnu
         ZeNA==
X-Forwarded-Encrypted: i=1; AJvYcCU24xToWaRl3DsIThJ+9Fs5ujzA0GeZS3uffcatum6Mp657Bl+u6dwyTS+CQS656Ojhxc+09IMIjLV4iyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVsUNeVC92kkUBia05BTD9N4t4Mj6sAureNWFVYxWZrq5skjI
	RtBUa6/AO5ljFj/hUurX2aLDKGxPEbVGVX/1ynTRc48lpT118HNrh+4wj9E4b6O6GmU/6OHU7kP
	eFLku+BSEc/4t6PdHJTz6t6MIB9+W3dAgSgoSyNRrLJ07YMYl5EkYe8mts441jQ==
X-Gm-Gg: ASbGnctuDmuN410/VWeZRA9tOZp6qIQ4hD3HNk1V7LgMaHwFVT6HBwt/HwLrO4sGSVG
	KVkGzf3id3b3JYc2rdb/xkLvlSV+F72zZtmqBXSinuAunBAB7QnzQ8NrHTte6R8g+lbRp4rE2ez
	TimT5bgUqepUC8Z/PW0goGCLqWAQzDPy8qVWIEAaT82JeYDBXoECximzKtXMADEQqIty3ulodtg
	koVIB0AxgcNIiDqv24XiXz20033WBz1jatTPqbTEasl2VnmHXBYqD+kSaXfBmPbutZlM/CI+kb/
	d2W2XXZAanUHWdrHSHETM/jCyN3F5S9lnkFjUd32Cwvuizw7Kf3kRT9EwO45H4m0x1NvE+MX
X-Received: by 2002:a05:6402:3589:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5e5e22a9443mr17057922a12.7.1741687300645;
        Tue, 11 Mar 2025 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjv/+3Hnz070c0jpTEuZGKRv3YWN2bvgQrRUiPNEroDj7rznpBt9RarcCiL+T4rK0S1nXivw==
X-Received: by 2002:a05:6402:3589:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5e5e22a9443mr17057856a12.7.1741687299960;
        Tue, 11 Mar 2025 03:01:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766d0e0sm8344611a12.64.2025.03.11.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:01:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 0/3] tpm: add send_recv() op and use it in tpm_ftpm_tee and tpm_svsm drivers
Date: Tue, 11 Mar 2025 11:01:27 +0100
Message-ID: <20250311100130.42169-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up to the discussion we had about whether or not
to add send_recv() op in tpm_class_ops[1].

Some devices do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer.
In order to simplify these drivers and avoid temporary buffers to be
used between the .send() and .recv() callbacks, introduce a new callback
send_recv(). This was suggested by Jason Gunthorpe while reviewing
the new SVSM vTPM driver, but the same callback can be used also for the
fTPM driver to simplify it a bit (second patch of this series).
I only successfully compiled fTPM, but I don't know how to test, if anyone
can test or suggest how to do it, I would be grateful.

This series is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" [2] (actually only the last patch in this series).

[1] https://lore.kernel.org/linux-integrity/Z8sfiDEhsG6RATiQ@kernel.org/
[2] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  tpm: add send_recv() op in tpm_class_ops
  tpm/tpm_ftpm_tee: use send_recv() op
  tpm/tpm_svsm: use send_recv() op

 drivers/char/tpm/tpm_ftpm_tee.h  |  4 --
 include/linux/tpm.h              |  2 +
 drivers/char/tpm/tpm-interface.c |  7 +++
 drivers/char/tpm/tpm_ftpm_tee.c  | 86 ++++++++------------------------
 drivers/char/tpm/tpm_svsm.c      | 46 ++++-------------
 5 files changed, 39 insertions(+), 106 deletions(-)


base-commit: f2cb83b7f8c58952b424a83bf86680f1263ad417
-- 
2.48.1


