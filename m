Return-Path: <linux-kernel+bounces-265184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A850593EDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3FA1C21799
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A6584DF1;
	Mon, 29 Jul 2024 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+VhDIrS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227F2119
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236157; cv=none; b=bwbaflCOJc5TpBKA/f7HKYpAQinxXLVW/CH4jEOFwiQtYCzuulJC0wiNxd+g0XcHkr4P0PUunuo3AaQT6mVRM9feZ9zG8hr1ZfJLrxmLt6a68WsQdCcz8XQgjyqIdauV9HjkJU4/nvhtVg41rZIcqBdscPIyXybjeMO2Dss2l7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236157; c=relaxed/simple;
	bh=o2f/k3fbOpy78TNOpxriyb94GrXVBTxBCSOf7g2Gy5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgB0z+ayZVlomm4uncqNGJujUCP36GO34NJMswf2NUrFZqW9HdlA8lw0wnAu2HYzRt2v3IXe5m++CKMLvBm4G4h/SyOa5o0/nyHcr+0HUgJzXtaT3qw5ZaPqqZYYka8vwfeTh/o8NldMmWaebvSmbK/lA6MjyOYLXXubnU5qnqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+VhDIrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722236153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7AWP/0qHqZ7Y61Eby5XenXroJ56XWtIdeweoRPAf8bU=;
	b=E+VhDIrSeYKvyHZuVl8k0kjMte52yDe1wy2XH0gWwOGUxTzVuh6LXyyHbsla00S811TfHl
	xJyrmHrEEOvlLvZMiGuBkRd03hmQNPHQteW1NUM0MXn/l4pz1OVZ996uNl+HKkvJwHTsNt
	RJB/IldBnX4vj3NrJT4m4SHNcikjORo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-ZuWaro6hMICjUhdJNh-ZdQ-1; Mon,
 29 Jul 2024 02:55:52 -0400
X-MC-Unique: ZuWaro6hMICjUhdJNh-ZdQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B61419560B1;
	Mon, 29 Jul 2024 06:55:51 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 404B51955D42;
	Mon, 29 Jul 2024 06:55:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Subject: Testing if two open descriptors refer to the same inode
Date: Mon, 29 Jul 2024 08:55:46 +0200
Message-ID: <874j88sn4d.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It was pointed out to me that inode numbers on Linux are no longer
expected to be unique per file system, even for local file systems.
Applications sometimes need to check if two (open) files are the same.
For example, a program may want to use a temporary file if is invoked
with input and output files referring to the same file.

How can we check for this?  The POSIX way is to compare st_ino and
st_dev in stat output, but if inode numbers are not unique, that will
result in files falsely being reported as identical.  It's harmless in
the temporary file case, but it in other scenarios, it may result in
data loss.

Thanks,
Florian


