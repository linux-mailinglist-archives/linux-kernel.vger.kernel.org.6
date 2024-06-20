Return-Path: <linux-kernel+bounces-222854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373AA9108A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681FE1C20FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC11AE087;
	Thu, 20 Jun 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itlpDont"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282826AE8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894493; cv=none; b=eZtld2jgkPf9JklfILrqhV7viq0ErYB1cXLc97woLHPA/l/4LLTOVhItWS6Mw34twWa82VP0/Cx5BNkFbtMK8hBjVpdO0A4KfOgkd/Zb+w0eHXqFaFchfv3+FKE/5nVq0P1oTFU7HovHc+xvWl74DRyynO4sHPdQLmgimkx/12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894493; c=relaxed/simple;
	bh=A2hAh3zljsENs4x7FwWKoh4/ZunSLDIC44JH9vluR4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAqOKjM7+/wBRtTXsjmure8ow7TasSg6Q7XCi0umthROepBr4uwNoFQv3+845vVWZ9bl1oecse/fcGhx2FftbKWtN/b0W0qqXaIkiCmb4Wy2OOrgA9m9wQhwBN16vvIHiSstdaAZ9bhB+2Kq6TnOO+N4kdP50r0QhK2QuuhHCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itlpDont; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718894491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdy5LyMULWck3Md4+bBBURmMFZ9PSYp6XgffXBG2oTQ=;
	b=itlpDontCet6Y3+J8yQlB0pdCC+r+pHr9dgOONars1wfBEfFayGuLbH65CDOYzrhom7oWQ
	KUlT3leafhN3PCdQjpXDy9mPLhphsZO9T/WuoQfQk/a7C9XSdngf5gsy30MIw7vOmy+cGZ
	a2T77CDcN7CG7WttSk91oJcB5uttOD4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-O9W2lsr3PiOgMXTtj8IMaA-1; Thu,
 20 Jun 2024 10:41:27 -0400
X-MC-Unique: O9W2lsr3PiOgMXTtj8IMaA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76958195608C;
	Thu, 20 Jun 2024 14:41:25 +0000 (UTC)
Received: from [10.22.34.111] (unknown [10.22.34.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 314DA19560AE;
	Thu, 20 Jun 2024 14:41:22 +0000 (UTC)
Message-ID: <b09f3db4-df3a-4dce-a490-32b38e97231a@redhat.com>
Date: Thu, 20 Jun 2024 10:41:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, jrani@purestorage.com,
 randyj@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20240619163503.500844-1-jmeneghi@redhat.com>
 <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240620065641.GA22113@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 6/20/24 02:56, Christoph Hellwig wrote:
>> +		WARN_ON_ONCE((atomic_dec_if_positive(&ns->ctrl->nr_active)) < 0);
> Overly long line.
> 
> But I don't understand why you need the WARN_ON anyway.  If the value
> must always be positive there is no point in atomic_dec_if_positive.
> If misaccounting is fine there WARN_ON is counterproductive.

Agreed. I wanted this here for testing purposes.  In all of my hours of running tests I never saw this warning go off, so I 
agree it should be removed.

/John


