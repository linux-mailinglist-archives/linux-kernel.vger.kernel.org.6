Return-Path: <linux-kernel+bounces-423954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB79DAEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E3328235A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20C2036E1;
	Wed, 27 Nov 2024 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrfQfsE1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A3200B95
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741030; cv=none; b=rjISzjkr+w2X7KRmDRBIZ17sK3/P+M/n6t86EzpPohukhod3LDIfeKb9Rbxe8L0RbrEA/O2/Wsh3eM8lC34N4ApYszrCzYl8lSRUGf3Bh9YAIqcJut3X8sr0GLMBGPCH+NLXt5M+3B+Hcsu4V3yKjGH3sV0Dh8bvDObCeDWLBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741030; c=relaxed/simple;
	bh=ntkWNEXiD3JT1EU9YhbTlyTxg9GZoKesv6JFTKMweOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxBJLoSj6HVF27GX+jeFp0wRS9T120qPX7CeWizoIKf5KYC9/zu+fqpC6X6gjVWxDylpovDKHeYz+1zwj/41rz4qRaulKym/xeOTQKBUcqkVPhSm5oeb/vYip6/vDDLlKf7cXYSnJ2jmBCIRjRZb+g8DWKZakr4ZO4iXnQERbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrfQfsE1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732741027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BOHRWyR3WO91hGTcRvvdOPqaUQq8joODn8hXKbKKdg=;
	b=GrfQfsE18YV+R++f5qvZmEYcbzh+sqD02FI6QNimzMScBTO3RskAc9nLQeXb1KG3pwKGv2
	T0zmrfvKTTDeTl+Hv4zbXQ70Gnwxyn3Nu65oHiTz2KSkBJU/dJNkXSom+2jA6gqdKtxgtz
	ZYoGtrlrDY3fA9Q4xINes3Dd2IclYWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-THgSyO5uPbyUPD3X0z21Tw-1; Wed, 27 Nov 2024 15:57:05 -0500
X-MC-Unique: THgSyO5uPbyUPD3X0z21Tw-1
X-Mimecast-MFC-AGG-ID: THgSyO5uPbyUPD3X0z21Tw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382428c257eso87846f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741024; x=1733345824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BOHRWyR3WO91hGTcRvvdOPqaUQq8joODn8hXKbKKdg=;
        b=pjZQy23JxhwqrOl36Uos15QbhKfiFAyVI4xuIA8hLRAImHK1KrosEKE3IC9EeTMAV1
         mO6RLsRKF9ESXcdSiijJmRQODX7fdsPp4SX37gMoIXjUuwxiTCP7TfK0JPUF5ZNviPM5
         n9uAu6GeL6emwrolnreSkshuQ53X4UPvhmE/CShUqyl8NOc7VXZ3V5neXXeDQFeBN2l9
         H/VcTdXtltX99uvoSc510ovgGSpeVGYcL0qzbI4pYycZlTp0Ng4+n+Sna9hMp34YygOw
         rzIz7oAXxeBaFaGwTGimIFKSY0RXL5BdF9p0vr21ZBV9S4mvlmCEcWxqytZK41etZevG
         Prsw==
X-Forwarded-Encrypted: i=1; AJvYcCVL3vPwDaXhMza3OmOA7D/WXlMs0Ga1SwQQTO8Xof5w24/gGds97uQwSKGFHdd3fujcUr2WXlWZ/3SkqMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqG2wjAmxpzJn5sXu8RziB2NNO3DMLrMrj8UqvdMUssq6Uj71l
	cuGLhYLEj8S0KjsCQnH2Jk6whj1iYc8jGSd3T2cwL5tSm9MiOod4zXs8DUGxaJcZDPus77BFv0X
	ZiyQkCzj+5uXFbT7L3iQGZets5NEgEI3ZGNUikM/98nXf6CMl+IEIqlnBh7Y1jltDewagqWjayn
	SKXotOaQgn2qIbXsCNA0jbbqs32ltdwq6u5H9H
X-Gm-Gg: ASbGncsqxXKOBckA3YNBkt/iyFVwUuSA3Du44en2Z162mXarKdoIP0MCZ3XYyREsW/M
	7IoacVCOY46wGU+oIssedjq/2NpqrO3U=
X-Received: by 2002:a5d:59ab:0:b0:382:42d7:eedc with SMTP id ffacd0b85a97d-385c6cca8dfmr3474635f8f.5.1732741024467;
        Wed, 27 Nov 2024 12:57:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/Jk9iiC7CS3fOEFWe7NMbtVU2FwnwlZ2ntREyi8wOExYMmsno/b4e6Lxcy3upQCG7cOnRuG/SGWt3IqGf718=
X-Received: by 2002:a5d:59ab:0:b0:382:42d7:eedc with SMTP id
 ffacd0b85a97d-385c6cca8dfmr3474622f8f.5.1732741024135; Wed, 27 Nov 2024
 12:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165405.2676516-1-max.kellermann@ionos.com>
 <CAO8a2Sg35LyjnaQ56WjLXeJ39CHdh+OTTuTthKYONa3Qzej3dw@mail.gmail.com> <CAKPOu+8NWBpNnUOc9WFxokMRmQYcjPpr+SXfq7br2d7sUSMyUA@mail.gmail.com>
In-Reply-To: <CAKPOu+8NWBpNnUOc9WFxokMRmQYcjPpr+SXfq7br2d7sUSMyUA@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 27 Nov 2024 22:56:53 +0200
Message-ID: <CAO8a2SiUL3T=MHcktWDaMbToqJYt7mYD_XN5G2nRAN0sxCHD7w@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/file: fix buffer overflow in __ceph_sync_read()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are correct, that is why I'm testing a patch that deals with all
cases where i_size < offset.
I will CC you on the other thread.

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..19b084212fee 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode,
loff_t *ki_pos,
        if (ceph_inode_is_shutdown(inode))
                return -EIO;

-       if (!len)
+       if (!len || !i_size)
                return 0;
        /*
         * flush any page cache pages in this range.  this
@@ -1200,12 +1200,11 @@ ssize_t __ceph_sync_read(struct inode *inode,
loff_t *ki_pos,
                }

                idx =3D 0;
-               if (ret <=3D 0)
-                       left =3D 0;
-               else if (off + ret > i_size)
-                       left =3D i_size - off;
+               if (off + ret > i_size)
+                       left =3D (i_size > off) ? i_size - off : 0;
                else
-                       left =3D ret;
+                       left =3D (ret > 0) ? ret : 0;
+
                while (left > 0) {
                        size_t plen, copied;



On Wed, Nov 27, 2024 at 10:43=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Nov 27, 2024 at 9:40=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > There is a fix for this proposed by Luis.
>
> On the private security mailing list, I wrote about it:
> "This patch is incomplete because it only checks for i_size=3D=3D0.
> Truncation to zero is the most common case, but any situation where
> offset is suddenly larger than the new size triggers this bug."
>
> I think my patch is better.
>


