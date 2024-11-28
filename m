Return-Path: <linux-kernel+bounces-424797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57749DB98D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCC1B22016
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDC1ADFF5;
	Thu, 28 Nov 2024 14:24:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EF1AA1FF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803888; cv=none; b=CdhoIhB5WUVyXSJXAcKsHGTZ7p5TbHfqlIWx0vragCoHadI0XeqiDf2qucAw5IKQwI6lbWQz6Mz7P4kRWzcOyKyZX/4VNBjaA0f+vQ/W8tG410pbrifWVlZv1OPO7mUbLwSIM4KVK9XzUHY8+a/mECkkdkmn+15e0ZFVH2I7EFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803888; c=relaxed/simple;
	bh=Rzixs9m/qrnsOkj/GLdkGDBoB4sOY2NHrJIoBphn7k8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+EehZ10/fyXRT+7Tx3XCFJkjAm0P8HJPxGvOicuEBwX/3K9Xzfa5sRNY1MvI8wi0LmFaNujMiUzJzP0khdtr6gyhTg27pp/ct2JWbe6OoXkURutxQMGq/czuTUiBvmDgRUtyUzcSLXOr0QQlmf7uHX5QqFsHJsvUNogc33Jhz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.2.4] (unknown [60.17.0.221])
	by APP-01 (Coremail) with SMTP id qwCowABnbHwbfUhnAxRVBg--.13292S2;
	Thu, 28 Nov 2024 22:24:28 +0800 (CST)
Message-ID: <c5971ce3de4e5f59e8013b1c6a5bf4158c69e6b8.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] riscv: module: use a plain variable for list_head
 instead of a pointer
From: laokz <zhangkai@iscas.ac.cn>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Paul Walmsley
	 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 28 Nov 2024 22:24:27 +0800
In-Reply-To: <20241128-0e953467c518d79d12dbf202@orel>
References: <20241127142519.3038691-1-cleger@rivosinc.com>
	 <980b98978ab4ee912b37cb101ad43bce20b56dcb.camel@iscas.ac.cn>
	 <20241128-0e953467c518d79d12dbf202@orel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowABnbHwbfUhnAxRVBg--.13292S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw48XFWfWFy5tr1fJFyrJFb_yoWfurgE9F
	yxZ34kWw1qgF17AanrKrs2vr93tr45Jr1UXryYqrsxZa4fWa95Zr18Ar95Zwn5JFsIy34a
	vFs8XryxtF97ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb28YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYYLPUUUUU=
X-CM-SenderInfo: x2kd0wxndlqxpvfd2hldfou0/

On Thu, 2024-11-28 at 09:32 +0100, Andrew Jones wrote:
> On Thu, Nov 28, 2024 at 09:01:52AM +0800, laokz wrote:
> > On Wed, 2024-11-27 at 15:25 +0100, Cl=C3=A9ment L=C3=A9ger wrote:
> > > rel_head's list_head member, rel_entry, doesn't need to be
> > > allocated,
> > > its storage can just be part of the allocated rel_head. Remove
> > > the
> >=20
> > Oh my poor English. OK, it's more better than just add the lost
> > kfree.
> >=20
>=20
> It wasn't the English I was correcting. That was fine, but just
> saying
> the object could be "a plain variable" wasn't giving any
> justification
> for the change and, to me, even implied that rel_entry was locally
> scoped. So, when I first skimmed the patch and saw that it was
> getting
> appended to a list, I almost stated the patch was wrong. It was clear
> after looking closer, but it could have been clear the first time
> through if the commit message had better guided me.

Thanks for the explanation.
laokz

> Thanks,
> drew


