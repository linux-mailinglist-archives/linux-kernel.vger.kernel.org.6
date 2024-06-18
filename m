Return-Path: <linux-kernel+bounces-218913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5290C7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BB1C212AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BB1BE248;
	Tue, 18 Jun 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQaYf6xr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461431BD914
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701702; cv=none; b=QXn6H+k70l5LGRAieA6qw7G4YHoiyJdhuMm5pYXBMfZP6g+PkIlv8QaOFHMYExij3sPVn05XpzU+eZvwbzvmGpmPgntnCJI11iD47ewmnrmPlzyctmhkEQK/ai1jgrLYq0oRPAjvIBrA7uuQBofbVvNf8gs61CPxwuW8H2EJQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701702; c=relaxed/simple;
	bh=CedmGa8cZ2BxtrlLmbeF2uubAoaL7BH6KJmCYay3qnc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXlegF0/Qxd59Xqkfsu0TDfrWO61uiMvkAQqeH0BEN3uzsCMMna6sD6yaZ4UOuY+4AJzH3cYDP74W4ZPv4Lxr/0K7uUmUaUUHFh3V3otYnE5xhXMQDw3XqqKZk+Z4CacreHL1Iz4n9DK8uT3Oz6Zui1o1LI0JPneqhyuF84ekcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQaYf6xr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718701698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lL7KZvqoxVX7mfVc2Z7x40SX7MdcEUbetSFvdcSCmVU=;
	b=UQaYf6xrDqbcGwDveiSsUY1DNeZg+YdXp3R22uhEWh3SpevYeBtLCQBvDh5B7eaqPldFgu
	TJdWyKkflWJB8mHwwyLZ7Chk6H+GATXm3wfC366TLGl9LcfVVVQ5AaIkoWoylPoIkWOSuX
	gz1bDZnAWgOcDjN0zU3F9EZpFwsnguM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-A1oGPZtbMzG_RjtQM9sVUA-1; Tue, 18 Jun 2024 05:08:16 -0400
X-MC-Unique: A1oGPZtbMzG_RjtQM9sVUA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b22e2dfa6cso76960846d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701695; x=1719306495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lL7KZvqoxVX7mfVc2Z7x40SX7MdcEUbetSFvdcSCmVU=;
        b=Ku2gNmn3vUfQ6YNUuix1fQJEo08EwURa4FO3DK2O7+l92aC99RWEoxoMky3jBVgAk4
         rWrjhKURrX17X5HP8XLB9c3Br/RUT7koQwpZx8gx8Qwc6OGWjViabFZL9Z0IaCW/kIir
         SoaastBcJuE54SdPOCCn5tqGe7LjD9qNJWhEiz4PxL6KpxI1M96dmr6wJ5RHOfqdHNDD
         0H5OZEZxRBA62HFkPh75tRhaNYcVWiJfGnIV132GrPuCFlZqC43a3kaJLONucTzO6iDt
         jgKjuyvJ4EkjZnPlZfaJRa/aZtHNrH1owYJplZ5xqKMDMB1wSLyQq+szUb5/raTWiWm5
         TC+g==
X-Forwarded-Encrypted: i=1; AJvYcCXSJmnno3AhtsZfDpk/d1Y9DwcjLtjW3Dpb2i4AysrEAn+cgPiN+2paVeg604eSBtuW2MJc2fE1KZNaPRYntZqdskSqFLt+817CnW60
X-Gm-Message-State: AOJu0YxcNgqgYaBMsVUEdfQae6EKRIHGbsYnf4cfsOfkhkcHVVypPW0u
	7UtVOIjG+lTN1EjoXzA5Ssxe7jERt0UwveZj6C2sefa9uirsLn6kPhFa2s2wzTXV6DK+DVW3ETD
	YSj0JZnsZqZ8c7z2k3uHHvLhh49x5xxQtE87kbExtcXUPG3lDrRP/Atth8hMW+qLPIY5ptxXaVN
	uvN6mmqXits3NMudikGvnwyjxAkJIbmk/f32HK
X-Received: by 2002:a05:6214:411c:b0:6b0:7735:9eff with SMTP id 6a1803df08f44-6b2afd94d1fmr164611906d6.23.1718701695558;
        Tue, 18 Jun 2024 02:08:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ3YNztvrs6RyERGRWb7sKDNttLNS9hJBnK8l7r55jhtzC/1VIeAQT1yZHXLYxlP5LwBJWVLmiu01WlgMtb3c=
X-Received: by 2002:a05:6214:411c:b0:6b0:7735:9eff with SMTP id
 6a1803df08f44-6b2afd94d1fmr164611726d6.23.1718701695240; Tue, 18 Jun 2024
 02:08:15 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 09:08:14 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <f7tzfrnmp0q.fsf@redhat.com> <CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=2xmPvAfQx4jSFbBPTcEdo2Z6w93vo6-Uo5rVMLbu8qS1SOA@mail.gmail.com>
Date: Tue, 18 Jun 2024 09:08:14 +0000
Message-ID: <CAG=2xmO-mtQOMABEAXNxEoa6NH5Hgae1x5+XWU5ZnLFg2n7b=g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, echaudro@redhat.com, horms@kernel.org, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 07:18:05AM GMT, Adri=C3=A1n Moreno wrote:
> On Fri, Jun 14, 2024 at 01:07:33PM GMT, Aaron Conole wrote:
> > Adrian Moreno <amorenoz@redhat.com> writes:
> >
> > > Add a test to verify sampling packets via psample works.
> > >
> > > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > > on the psample multicast group and print samples.
> > >
> > > In order to also test simultaneous sFlow and psample actions and
> > > packet truncation, add missing parsing support for "userspace" and
> > > "trunc" actions.
> >
> > Maybe split that into a separate patch.  This has a bugfix and 3
> > features being pushed in.  I know it's already getting long as a series=
,
> > so maybe it's okay to fold the userspace attribute bugfix with the pars=
e
> > support (since it wasn't really usable before).
> >
>
> OK. Sounds reasonable.
>
> > > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > > ---
> > >  .../selftests/net/openvswitch/openvswitch.sh  |  99 +++++++++++++++-
> > >  .../selftests/net/openvswitch/ovs-dpctl.py    | 112 ++++++++++++++++=
+-
> > >  2 files changed, 204 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b=
/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > index 5cae53543849..f6e0ae3f6424 100755
> > > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > > @@ -20,7 +20,8 @@ tests=3D"
> > >  	nat_related_v4				ip4-nat-related: ICMP related matches work with S=
NAT
> > >  	netlink_checks				ovsnl: validate netlink attrs and settings
> > >  	upcall_interfaces			ovs: test the upcall interfaces
> > > -	drop_reason				drop: test drop reasons are emitted"
> > > +	drop_reason				drop: test drop reasons are emitted
> > > +	emit_sample 				emit_sample: Sampling packets with psample"
> > >
> > >  info() {
> > >      [ $VERBOSE =3D 0 ] || echo $*
> > > @@ -170,6 +171,19 @@ ovs_drop_reason_count()
> > >  	return `echo "$perf_output" | grep "$pattern" | wc -l`
> > >  }
> > >
> > > +ovs_test_flow_fails () {
> > > +	ERR_MSG=3D"Flow actions may not be safe on all matching packets"
> > > +
> > > +	PRE_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
> > > +	ovs_add_flow $@ &> /dev/null $@ && return 1
> > > +	POST_TEST=3D$(dmesg | grep -c "${ERR_MSG}")
> > > +
> > > +	if [ "$PRE_TEST" =3D=3D "$POST_TEST" ]; then
> > > +		return 1
> > > +	fi
> > > +	return 0
> > > +}
> > > +
> > >  usage() {
> > >  	echo
> > >  	echo "$0 [OPTIONS] [TEST]..."
> > > @@ -184,6 +198,89 @@ usage() {
> > >  	exit 1
> > >  }
> > >
> > > +
> > > +# emit_sample test
> > > +# - use emit_sample to observe packets
> > > +test_emit_sample() {
> > > +	sbx_add "test_emit_sample" || return $?
> > > +
> > > +	# Add a datapath with per-vport dispatching.
> > > +	ovs_add_dp "test_emit_sample" emit_sample -V 2:1 || return 1
> > > +
> > > +	info "create namespaces"
> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > > +		client c0 c1 172.31.110.10/24 -u || return 1
> > > +	ovs_add_netns_and_veths "test_emit_sample" "emit_sample" \
> > > +		server s0 s1 172.31.110.20/24 -u || return 1
> > > +
> > > +	# Check if emit_sample actions can be configured.
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	'in_port(1),eth(),eth_type(0x0806),arp()' 'emit_sample(group=3D1)'
> > > +	if [ $? =3D=3D 1 ]; then
> > > +		info "no support for emit_sample - skipping"
> > > +		ovs_exit_sig
> > > +		return $ksft_skip
> > > +	fi
> > > +
> > > +	ovs_del_flows "test_emit_sample" emit_sample
> > > +
> > > +	# Allow ARP
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> > > +
> > > +	# Test action verification.
> > > +	OLDIFS=3D$IFS
> > > +	IFS=3D'*'
> > > +	min_key=3D'in_port(1),eth(),eth_type(0x0800),ipv4()'
> > > +	for testcase in \
> > > +		"cookie to large"*"emit_sample(group=3D1,cookie=3D1615141312111009=
080706050403020100)" \
> > > +		"no group with cookie"*"emit_sample(cookie=3Dabcd)" \
> > > +		"no group"*"sample()";
> > > +	do
> > > +		set -- $testcase;
> > > +		ovs_test_flow_fails "test_emit_sample" emit_sample $min_key $2
> > > +		if [ $? =3D=3D 1 ]; then
> > > +			info "failed - $1"
> > > +			return 1
> > > +		fi
> > > +	done
> > > +	IFS=3D$OLDIFS
> > > +
> > > +	# Sample first 14 bytes of all traffic.
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	"in_port(1),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.10,proto=
=3D1),icmp()" "trunc(14),emit_sample(group=3D1,cookie=3Dc0ffee),2"
> > > +
> > > +	# Sample all traffic. In this case, use a sample() action with both
> > > +	# emit_sample and an upcall emulating simultaneous local sampling a=
nd
> > > +	# sFlow / IPFIX.
> > > +	nlpid=3D$(grep -E "listening on upcall packet handler" $ovs_dir/s0.=
out | cut -d ":" -f 2 | tr -d ' ')
> > > +	ovs_add_flow "test_emit_sample" emit_sample \
> > > +	"in_port(2),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.20,proto=
=3D1),icmp()" "sample(sample=3D100%,actions(emit_sample(group=3D2,cookie=3D=
eeff0c),userspace(pid=3D${nlpid},userdata=3Deeff0c))),1"
> > > +
> > > +	# Record emit_sample data.
> > > +	python3 $ovs_base/ovs-dpctl.py psample >$ovs_dir/psample.out 2>$ovs=
_dir/psample.err &
> > > +	pid=3D$!
> > > +	on_exit "ovs_sbx test_emit_sample kill -TERM $pid 2>/dev/null"
> >
> >   Maybe ovs_netns_spawn_daemon ?
> >
>
> I'll take a look at it, thanks.
>

I've looked into ovs_netns_spawn_daemon and I think it'll not be useful
for this command since it needs to run in the default namespace. I can
add a new "ovs_spawn_daemon" so it's reusable. WDYT?

> [...]


