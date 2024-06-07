Return-Path: <linux-kernel+bounces-205451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F198FFC33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4793285F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89614EC75;
	Fri,  7 Jun 2024 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xdCcH+tI"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4718AF4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741524; cv=none; b=f1xRhMQipGUfUlcTcS+7j+nEMMWMCAkhwfaD5yyhUdgAHsDQ7PU6Xn6BCWskl+fXBCMh+Kz8SOsAdnGwRFP08oTbQMrJi6sU1zubMOo9JGs0PFLU1UxUVGXOpKmk+K8DOPVu+YocY70pJyn5c8lgrW+iop7V1vPAInd9i2Ppl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741524; c=relaxed/simple;
	bh=wE/R/t5j7RmtTx7ndh8HOfKlFGmFGqY1/Yk4tvIlyLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ir12fAMCpk9x5GEGxfT3uJ54TK34pPsNKJAdoxxV2dD5dQnrrL5ngUMvlTRvoJDdxVxwxi+nLwDQD7IABQfs2xZF+Fo9G1RxKdaJGc8b/yRYBW1CokNev6FciXanLcbn+tjawzge3REmfkM06AWg9XM0auma1QiDJKx46H91tQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xdCcH+tI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hch@lst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717741520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+m/nTQGXSyjTen2jr8IGQUJ8mP1sxHUVx39nE+L9CKc=;
	b=xdCcH+tI0aeYp6KqObrL8aemNZ6sQ9PgIZCLqCjfd4gECosqAMCxlgBTERDvCymS4uBYXa
	kzDE2j2kHq7lhuFVD5SwrTXDIB6+Tz1jR2D8B4mXxki/u0sMWzjX0L48K2BOHc/lHO3FxC
	jPW4eRbjl/qp2jJEwNwho+jh38G9AIY=
X-Envelope-To: f.weber@proxmox.com
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: t.lamprecht@proxmox.com
Message-ID: <2223bbb9-8bc8-4566-9c3f-ef6103422068@linux.dev>
Date: Fri, 7 Jun 2024 14:24:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
 <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
 <dea87c0a-1c36-4737-bea5-cb7fa273b724@linux.dev>
 <20240607045511.GB2857@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240607045511.GB2857@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/7 12:55, Christoph Hellwig wrote:
> On Fri, Jun 07, 2024 at 10:37:58AM +0800, Chengming Zhou wrote:
>> Yeah, right, it seems LVM may create this special request that only has
>> PREFLUSH | POSTFLUSH without any DATA, goes into the flush state machine.
>> Then, cause the request double list_add_tail() without list_del_init().
>> I don't know the reason behind it, but well, it's allowable in the current
>> flush code.
> 
> PREFLUSH | POSTFLUSH is a weird invalid format.  We'll need to fix this
> in dm, and probably also catch it in the block layer submission path.
> 

Right, how about add WARN here to catch it? Or just set it to PREFLUSH?
Not familiar with dm code, need help if we need to fix it in dm. :)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c17cf8ed8113..3ce9ed78c375 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -185,7 +185,7 @@ static void blk_flush_complete_seq(struct request *rq,
                /* queue for flush */
                if (list_empty(pending))
                        fq->flush_pending_since = jiffies;
-               list_move_tail(&rq->queuelist, pending);
+               list_add_tail(&rq->queuelist, pending);
                break;

        case REQ_FSEQ_DATA:
@@ -263,6 +263,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
                unsigned int seq = blk_flush_cur_seq(rq);

                BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
+               list_del_init(&rq->queuelist);
                blk_flush_complete_seq(rq, fq, seq, error);
        }

@@ -402,6 +403,12 @@ bool blk_insert_flush(struct request *rq)
        unsigned int policy = blk_flush_policy(fflags, rq);
        struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);

+       /*
+        * PREFLUSH | POSTFLUSH is a weird invalid format,
+        * need to fix in the upper layer, catch it here.
+        */
+       WARN_ON_ONCE(policy == (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH));
+
        /* FLUSH/FUA request must never be merged */
        WARN_ON_ONCE(rq->bio != rq->biotail);


