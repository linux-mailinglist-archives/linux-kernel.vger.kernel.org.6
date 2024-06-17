Return-Path: <linux-kernel+bounces-217986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7A90B759
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FC71C23501
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514616A922;
	Mon, 17 Jun 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="damAW26K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577E157A41
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643834; cv=none; b=e3RfBNfLCnxXc/eL7OxzX6Z+i0Dm0QacOrS5h7+IDQ0AnI+hSGu+/+Xu7Ml1ZyYmPBm923D1+x3vRbTR3Ct44Fw8Z9h2me30H6/s+uuzHsPeBCbEs/qWzs4fCU7sYIJNb03ySnugc97oVOgGZu5JS8NoMkzJtGnhVhbk0g2+DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643834; c=relaxed/simple;
	bh=B/R8WA6WlTKBoMtymOfA0Nro8DiMzssb/IKYqtrx+Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMJAlqpXLIPZfm0b2QY6GY62MdFcLVjcZ3FOCXR1IEgptZlYb/aoWxB1M4mE/6kUVpuvcxHlp7fSTp0VX8rmZdCF2cu/rlBNZZehNnpL+NurNMJht11n0F2SsDMsE93RJ5I3TTj58Y4pQMbsCT0Me1nIjNDk1e0WIBnQdCcxxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=damAW26K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718643831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YHkJpS60MhN5lMwMCOpjfC0+4wq7Fy7UnAEliYelB4=;
	b=damAW26KmiCL8cybNkcUmTmNHJaQqiyHGgPcHn3EIiwAqE6z9tK6DaMoMIUx2epN7SQ/Cv
	XvZTCNkncuGE7igOfT6HiDEQ799U/AzmFIyCaWWQ8lNh0u212HBRnIyXXCY7VQH9cZEKYj
	J2WsT/bbet3CwVuaUf1n4B45hRDUFgg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-czTxwAs4OBiE2wmrnBfFyg-1; Mon,
 17 Jun 2024 13:03:47 -0400
X-MC-Unique: czTxwAs4OBiE2wmrnBfFyg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61DEA1956096;
	Mon, 17 Jun 2024 17:03:44 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B80A1956048;
	Mon, 17 Jun 2024 17:03:41 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org,  Ilya Maximets <i.maximets@ovn.org>,
  Stefano Brivio <sbrivio@redhat.com>,  Eric Dumazet <edumazet@google.com>,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,  "David
 S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 5/7] selftests: openvswitch: Support
 implicit ipv6 arguments.
In-Reply-To: <20240616162855.GK8447@kernel.org> (Simon Horman's message of
	"Sun, 16 Jun 2024 17:28:55 +0100")
References: <20240613181333.984810-1-aconole@redhat.com>
	<20240613181333.984810-6-aconole@redhat.com>
	<20240616162855.GK8447@kernel.org>
Date: Mon, 17 Jun 2024 13:03:39 -0400
Message-ID: <f7tmsnjmrh0.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Simon Horman <horms@kernel.org> writes:

> On Thu, Jun 13, 2024 at 02:13:31PM -0400, Aaron Conole wrote:
>> The current iteration of IPv6 support requires explicit fields to be set
>> in addition to not properly support the actual IPv6 addresses properly.
>> With this change, make it so that the ipv6() bare option is usable to
>> create wildcarded flows to match broad swaths of ipv6 traffic.
>> 
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> ---
>>  .../selftests/net/openvswitch/ovs-dpctl.py    | 43 ++++++++++++-------
>>  1 file changed, 28 insertions(+), 15 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> index 5545e5cab1d6..2577a06c58cf 100644
>> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> @@ -200,6 +200,19 @@ def convert_ipv4(data):
>>  
>>      return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
>>  
>> +def convert_ipv6(data):
>> +    ip, _, mask = data.partition('/')
>> +
>> +    if not ip:
>> +        ip = mask = 0
>> +    elif not mask:
>> +        mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
>> +    elif mask.isdigit():
>> +        mask = ipaddress.IPv6Network("::/" + mask).hostmask
>> +
>> +    return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
>> +
>> +
>
> nit: Perhaps one blank line is enough

Sure - dropped.

>>  def convert_int(size):
>>      def convert_int_sized(data):
>>          value, _, mask = data.partition('/')
>
> ...
>
> The nit above notwithstanding, this patch looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org>


