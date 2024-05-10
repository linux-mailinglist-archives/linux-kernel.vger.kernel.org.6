Return-Path: <linux-kernel+bounces-175467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AF8C201B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D171B210B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1CB15FA7B;
	Fri, 10 May 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJBEhg5x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8A5256
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331298; cv=none; b=eIB0+RzzPraYCtPkneXaY5bJF2sn8RfiTCuZVgurdmSVDC0C2hswt8hQkdI7ubzbWRake7rBX/0aZ8cP1L8Evt5z52FS/wLKWf0esDipPCLlonbYE9d45VUIesLIFK9fvL7MSWlUA9hYuj3l/EBRmG34i1An4QEzTqZaAkpRJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331298; c=relaxed/simple;
	bh=Oext9QCRm3qp1ljmGuVJ+5/G39APiXZEk6YUiMRR/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJvHw41AqNQsFuja7+AdVH+z3LxKW52ZwFXndzhIpWF9ZpZZc3qWvU7+5FZkOW4w0FdPD5sZkQU4B8MOF6zSzz8Cq5iQ7Vo2n5fcC+UkkpHCiC5j78TvzeBOM6FpRQPuwS93fIir/bp0tXGhkaD4Kv8MPNshGJtteWjYxIbj1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJBEhg5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715331295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oext9QCRm3qp1ljmGuVJ+5/G39APiXZEk6YUiMRR/1A=;
	b=hJBEhg5xLt8fC45x1NCvua4taXXVDor5gY+R3yStHBbCMVt7VsVLwz7VSokWOn8Q9cnyMC
	p7B6Z27sLMC8KQglYklxl+CrTo05qPa8sEuTQpT4VxJWwj2aMIhvVSNQhCURBxQL2PqWnf
	Jho2AhuETRnhAZULE9xsvVptKCX2RJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-DGK1vVlWMcGqtZbO3QCJWQ-1; Fri, 10 May 2024 04:54:53 -0400
X-MC-Unique: DGK1vVlWMcGqtZbO3QCJWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FC2C812296;
	Fri, 10 May 2024 08:54:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68F6051903D;
	Fri, 10 May 2024 08:54:51 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH v2] module: create weak dependecies
Date: Fri, 10 May 2024 10:54:49 +0200
Message-ID: <20240510085450.293792-1-jtornosm@redhat.com>
In-Reply-To: <5o5jlonbr2ggei7zxh7m2mql3rt6xnmmmo2hv6ktpvi26c7uuw@odtumzc76xoq>
References: <5o5jlonbr2ggei7zxh7m2mql3rt6xnmmmo2hv6ktpvi26c7uuw@odtumzc76xoq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

> I think it's important a note about backward compatibility. If a system
> doesn't have a new-enough depmod, it will basically not create the new
> weadep file and initrd generators won't be able to use that. Only
> downside is not being able to use the new feature, but it should still
> work as previously.
Ok, good, idea, I will send a new version of the patch with the note.

Documentation/process/coding-style.rst section 8 says to balance the /*
and */, but up to Luis what he enforces in the module tree.
Ok, I will fix that too.

Thanks

Best regards
José Ignacio


