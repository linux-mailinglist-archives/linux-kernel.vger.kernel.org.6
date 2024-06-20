Return-Path: <linux-kernel+bounces-222724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D531910639
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56101F260EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2421AE0A0;
	Thu, 20 Jun 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHe57qic"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DD1AD3EB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890302; cv=none; b=Ec2D3yibywn7Whtf8mz5Qe881FQqO7waqSe1bPXkd/Fzjqq5A/bGoxJCn73ajTH4pbhMPeOwm2Yz3FC06AI64gRJRjkVnTasGdCv4HJ4RfAgW/+OsKtfAzTAdv7tk513XnYlR5714tP+/rxUdcKsO1pdvXhYbC/sxfqoqn4cbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890302; c=relaxed/simple;
	bh=ppX6VBx7+1zsn2VbQNl3tkDpaOj+UZLirFEMqA8idfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebwtdfodoXU2ypYnMedWlNHN1VH+0cNSEBz7h4rk0uYvr9hH6zf6yNdvKzGqfOhBRQH3EO6Pse4+xDVw3abNmaUs+gU+7uS4V+s3d8QkbFa7j5ZpBGyc2O7ibW4CE2r6K3Pq1J90ILGROPDAkekUiJmcFwJe0IAX/lKYA7ngggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHe57qic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718890300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vE+mxyg8YyUZt5GQS1+ElW8LtSozIu63aF5ZDw92HPo=;
	b=PHe57qic3IuiCnuykqRTjFQhxFPavZQ1huUjxI5nRlR+MTeskRdXvcnCuFcGHWu3o7ES3E
	TQE70l3Mmuzu18C6NosVS4zEvaIOLxmPQHMzgr8NAjPsQTDMiZCrY33KGCmB0irG5uf2Mj
	eURF9pJ3cauqrhzjYvwofbbnyVxCWCI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-mEWm_jU-PZ-8LL1KS58Nvw-1; Thu,
 20 Jun 2024 09:31:37 -0400
X-MC-Unique: mEWm_jU-PZ-8LL1KS58Nvw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229C01955D68;
	Thu, 20 Jun 2024 13:31:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.104])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3988E1956087;
	Thu, 20 Jun 2024 13:31:25 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: ax88179_178a: improve link status logs
Date: Thu, 20 Jun 2024 15:31:20 +0200
Message-ID: <20240620133124.102154-1-jtornosm@redhat.com>
In-Reply-To: <c76d1786c308aeb6e4c836334084e3049c0f108a.camel@redhat.com>
References: <c76d1786c308aeb6e4c836334084e3049c0f108a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello Paolo,

> Please always include the target tree in the subj prefix - in this case
> it should have been 'net'.
Ok, I forgot it.

> Here                                ^^^^ link value is always 0, so you
> should using a constant string.
Ok, better in that way.

I will send a next version of the patch.

Thanks

Best regards
José Ignacio


