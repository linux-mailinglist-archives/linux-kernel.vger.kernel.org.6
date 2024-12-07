Return-Path: <linux-kernel+bounces-435912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B49E7E81
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7225D281004
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9178C90;
	Sat,  7 Dec 2024 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp/sSpVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD544A1C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733552201; cv=none; b=AyDiBLTeraEiDD5xWHUDk2iAzV3LP/TBy6P2ZFx7r+tF/OV4D6EiWweztAq1QsWM6FXQ5RRiiBNQ8qzzz4BT0BWIYChA4UGj5ADWf4GmUBgPh+AvZTtdYuhapD8QqJPLDwKK9CyMBz6kNigZvnsjVgDN5y8oYYMTAHTen6Zy4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733552201; c=relaxed/simple;
	bh=yTdSpqoD5Wo8lytAenLlCl4aoNvxFahwiv6XfLPtJZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7e+7V99ZITyY/To0TbOoDEAtrrwK+75mUkafg0Dbz+vJIODVmnN71yYxGklrr+DlWuqhHc6M+kp6K0gsRVrZKRg8ecntIaJiP/KbiAM9AV8wK9wXcXFnuOsH409Puz/zIFgOHjBXSRnY6l4QWsRau0IU2UPcVBM0fBTbaiIbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp/sSpVN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733552198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IndLci3qH0rNwV6wj/O0mA1mXhMlv9zVXl1VfWtqCCE=;
	b=Kp/sSpVNI3X5d9MiBILcQmvPvfHsjhzEg5DzJLdVBUQm0m8uwUN1IDanawmHDNB7DxHrey
	qSa3SMyAQYS/OT9OQFYSkc4STSdH15y71r2tZBnCiUuDBG+432+tS+6xwm65qrfMJQ/Lmi
	yaK2m6TswUvFWqvcRDkKFRa1iGbqbtE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-QpACtTbuNpWzAJcCiT1t4w-1; Sat,
 07 Dec 2024 01:16:35 -0500
X-MC-Unique: QpACtTbuNpWzAJcCiT1t4w-1
X-Mimecast-MFC-AGG-ID: QpACtTbuNpWzAJcCiT1t4w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13B051956086;
	Sat,  7 Dec 2024 06:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91881300019E;
	Sat,  7 Dec 2024 06:16:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4847921E66E2; Sat,  7 Dec 2024 07:16:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Shiju Jose <shiju.jose@huawei.com>,
  Dongjiu Geng <gengdongjiu1@gmail.com>,  Igor Mammedov
 <imammedo@redhat.com>,  linux-kernel@vger.kernel.org,
  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 27/31] DEBUG
In-Reply-To: <CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
	(Ani Sinha's message of "Sat, 7 Dec 2024 09:08:31 +0530")
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
	<6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
	<CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
Date: Sat, 07 Dec 2024 07:16:31 +0100
Message-ID: <87ser02f28.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ani Sinha <anisinha@redhat.com> writes:

> On Fri, Dec 6, 2024 at 10:51=E2=80=AFPM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>  hw/acpi/ghes.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
>> index abca351b18de..1fe4c536611a 100644
>> --- a/hw/acpi/ghes.c
>> +++ b/hw/acpi/ghes.c
>> @@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, size=
_t len,
>>      ags =3D &acpi_ged_state->ghes_state;
>>
>>      if (!ags->hest_lookup) {
>> +        fprintf(stderr,"Using old GHES lookup\n");
>
> I don't like this. If you must please have them under #ifdef DEBUG or
> somesuch. See ich9.c

Judging from the subject line, it's not meant to be posted, let alone
merged :)

>>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>>                               &cper_addr, &read_ack_register_addr);
>>      } else {
>> +        fprintf(stderr,"Using new HEST lookup\n");
>>          get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_l=
e),
>>                                  &cper_addr, &read_ack_register_addr, er=
rp);
>>      }
>> --
>> 2.47.1
>>


