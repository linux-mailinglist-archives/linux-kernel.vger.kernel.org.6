Return-Path: <linux-kernel+bounces-425549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A279DE69A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B018BB20A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C2D19D098;
	Fri, 29 Nov 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw89ivNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9071195980
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884098; cv=none; b=Wgltz2OtQYchSq0bXn6hwik0BtAiyWj1jylAhSIuIuJjVJpR/fPQ8MdDmCNrXZpoM1wM8tx0i/z4y9pysURNO6RIaJDpf6iwaH7GOfXG3kLAe0BP/BWpoDXNpptGzETqU1pJKhfF4VD0DGT1AfoCrD+DxNjS8GBxVkhT43RPWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884098; c=relaxed/simple;
	bh=/5hkHpGXIRPZIGRYrzi9fORbfclpImv7n31LW92dn5U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mbJbEaLg9Nj9X48NMjuxSeXewSxvfZiigq8bn9UVUd9NeggxIFEsTTpNykmJnbSA8V00ma7EEFRV/g8qu9s1ugcDfK1kgBb3O3lHJP0qzEb3n9F1+LSHyTi6hk5rx4d8Sfgqpg3NXhph8OkVJ2a8oAPk1t8E4VukEJ3m2T+WtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cw89ivNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732884094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRkQ7caS5vjHyMGGRL+u1PZKOEaI3catRgsdocSqOXY=;
	b=Cw89ivNwibNW/rfK7d1J1dON8bSkfqy51Hd+c3uvmGLlmYJqHsDd3ztPDMtUWhbQU9SVG0
	uA7EfGQ8jE8GUaSows9QtLAbE9uaaTKtbldrviZvIMpp3wfAosJ0FK1AD+K2l38PQEnD+4
	EpndUAypxFDwbjNVNuaAkPONNlifO7o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-sMpMOHflNWmnyAF14Y2mUQ-1; Fri,
 29 Nov 2024 07:41:31 -0500
X-MC-Unique: sMpMOHflNWmnyAF14Y2mUQ-1
X-Mimecast-MFC-AGG-ID: sMpMOHflNWmnyAF14Y2mUQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 690E819560AB;
	Fri, 29 Nov 2024 12:41:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B625230001A2;
	Fri, 29 Nov 2024 12:41:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3990749.1732884087.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Nov 2024 12:41:27 +0000
Message-ID: <3990750.1732884087@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Max,

Could you try:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-writeback

I think the patches there should fix it.

However, as these aren't making it till the next merge window, I'll try an=
d
work out an interim fix.

David


