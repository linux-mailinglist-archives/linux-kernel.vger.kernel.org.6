Return-Path: <linux-kernel+bounces-236745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A3C91E696
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA0AB21C73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E916EB42;
	Mon,  1 Jul 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFUvOXsh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A619126F1E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854732; cv=none; b=G3oB+hLGd4xXTAgauamnV8vAAqlN8wAgDGEgY5Ce50skPTj+hHntLkngeKwwKIdZH43ZPqdWlacOQ5SzmUn9+G7oMZHcwg2FzY6SeIqj02zDCWq4lRt0REuyfFECufAF5fZzx5ThkU7D6xT0IxfbgNdaunWKecoBSkHZDYf8USg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854732; c=relaxed/simple;
	bh=aijWMinS3/Cl+sVa8RAsMtumkM0V2JKgXj2DJXZhUok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWNkyKWCzuQCk2MNl/6Jwj5cWh1HfXypHBjOrvjTBZTqvQiHiAxhMrWxvORLLdkLQJO51qlsarxcV+TtXwHJnV6o/z3xz7MRfl/tH4TpR7nWAcOGGGFvagVypINrk3f8ABTApC6+EPuaRyyKR0ZNuNFtGq3MniOX9eoHFOuFyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFUvOXsh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so23275125ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854731; x=1720459531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYrXt/RrJXu2c0c790MOYBofpqZy6fGBFKHQFa14QyM=;
        b=IFUvOXshgNy/250yqOJSUT2CdlpNTWkBM+2puFdOyqQZpJLKUL2Np8HlSv/sR09ezX
         baiUc5gBHZpcmNOOGG/yFQ3r+/o/sjjRn9LGru8zcQsrqcSW55AG71eYKe+bTmtpNGd/
         UoHa9fYyCZU0K6BeKL8CZixhszJ0GMr1HWxLqBpCqn1N7+Wk1zVpt0xsZWR64I83fsg0
         cfKxkJSwSybLR38cItLO+2jyeNX1MftLBmW6ilEYTtF7LUnRIij7HiH1ThmwfAv9cSJo
         x7Ou3vAwkODBDPYORA5B41Y2Kk0kX/SuSyqKjdAXl8wnipsveQQEXJSlPXASWhnkAOFt
         tIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854731; x=1720459531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYrXt/RrJXu2c0c790MOYBofpqZy6fGBFKHQFa14QyM=;
        b=CpXynThpLTjyTnh8JPeb843HZUO0KCUW7EovzD9PF6KDzyTEZUwL8itNFFdZEeGlne
         ufEd6AOlxH7+w2x/mubq99cFK8AtDR+Ug0urTYAukara9fs9afQp7sFLsYzunSePC0Y9
         xiaXDiaEvaMtWQ0nfw7BmPMCymOpOy7BnIUwgI/YZycqpOwfUmbMYD+Tr1Vdzuug8GhB
         bI2Fp81OCJdiUPPEY3SXzgc//qeFRAFwXAFeDT+yKBcsW5PSpWkxRFltGmcEmKZzCKtS
         1pWRAARH0lId4s1KdekBTtTgvyvQkdlp9X1oVcpd6gD2SfTP4p8RJpaUX0MVqkyAB/Fr
         YDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH8BRkPd9Hiq5vGt+MskCBSI6hN1WqawS/UW6ZrQk2vSgLEdON+YX3gfX2KsHlTe0uWXqeP/4WRww7oqCe9u8gi5z2HnMd/BatFMcx
X-Gm-Message-State: AOJu0YzBU7BQd3zQAqNzrc4ryYNUTLd848Ynuo57LrXA96a7DdVmq7JY
	/9Il5sZwyCpB09V3FgdLlsXSJDJFxSYIAsHBdY0RbccaRDy//fd+
X-Google-Smtp-Source: AGHT+IFngXRQ0EXxDqvNM5KNS4OFPMVY7KW0L47bGeBUZHL3yUUiYF4UV5ZzCgkhrJVOcrVVmWy1kQ==
X-Received: by 2002:a17:902:ea0e:b0:1f9:f3aa:fa86 with SMTP id d9443c01a7336-1fac7f1b664mr161379425ad.33.1719854730542;
        Mon, 01 Jul 2024 10:25:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159686csm67502255ad.266.2024.07.01.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:25:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 07:25:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Laurence Oberman <loberman@redhat.com>,
	Jonathan Brassow <jbrassow@redhat.com>,
	Ming Lei <minlei@redhat.com>, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, users@lists.libvirt.org
Subject: Re: dm-crypt performance regression due to workqueue changes
Message-ID: <ZoLmh5L7WrBqtn79@slm.duckdns.org>
References: <32fd8274-d5f-3eca-f5d2-1a9117fd8edb@redhat.com>
 <ZoGSJWMD9v1BxUDb@slm.duckdns.org>
 <e64c112-4fa9-74da-68ce-c1eec19460f2@redhat.com>
 <ZoKqYg7TKiozapmW@redhat.com>
 <e52c5a40-8ca9-38ae-1595-3785c6ac435@redhat.com>
 <ZoK0kwzis1iWVyLr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoK0kwzis1iWVyLr@redhat.com>

Hello,

On Mon, Jul 01, 2024 at 02:52:19PM +0100, Daniel P. Berrangé wrote:
...
> None the less, I'd suggest that virt-manager should be a explicitly
> asking for sockets=1,cores=N, as that has broader guest OS compatibility.

+1. Multiple sockets is pretty uncommon and often comes with significant
performance implications - e.g. if VM is also splitting memory into N nodes,
that can lead to significant higher overhead during reclaim due to node
imbalances and premature OOMs. If the reported topology is not real, it
makes a lot more sense to keep it basic.

Thanks.

-- 
tejun

